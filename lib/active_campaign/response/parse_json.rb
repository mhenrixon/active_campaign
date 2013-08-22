module ActiveCampaign
  module Response
    # Public: Parse response bodies as Oj.
    class ParseJson < Faraday::Response::Middleware
      CONTENT_TYPE = 'Content-Type'.freeze
      MIME_TYPE = 'application/json'.freeze
      BRACKETS = %w- [ { -
      WHITESPACE = [ " ", "\n", "\r", "\t" ]

      dependency do
        require 'oj' unless defined?(::Oj)
      end

      def parser
        lambda { |body|
          ::Oj.load body unless body.strip.empty?
        }
      end

      def initialize(app = nil, options = {})
        super(app)
        @options = options
        @content_types = Array(options[:content_type])
      end

      def call(environment)


        @app.call(environment).on_complete do |env|
          process_response(env)
        end
      end

      def process_response(env)
        old_type = env[:response_headers][CONTENT_TYPE].to_s
        new_type = MIME_TYPE.dup
        new_type << ';' << old_type.split(';', 2).last if old_type.index(';')
        env[:response_headers][CONTENT_TYPE] = new_type

        env[:raw_body] = env[:body] if preserve_raw?(env)
        env[:body] = parse(env[:body])
      end

      def parse(body)
        parser.call(body)
      end

      def response_type(env)
        type = env[:response_headers][CONTENT_TYPE].to_s
        type = type.split(';', 2).first if type.index(';')
        type
      end

      def process_response_type?(type)
        @content_types.empty? or @content_types.any? { |pattern|
          pattern.is_a?(Regexp) ? type =~ pattern : type == pattern
        }
      end

      def parse_response?(env)
        env[:body].respond_to?(:to_str) &&
        BRACKETS.include?(first_char(env[:body]))
      end

      def preserve_raw?(env)
        env[:request].fetch(:preserve_raw, @options[:preserve_raw])
      end

      def first_char(body)
        idx = -1
        begin
          char = body[idx += 1]
          char = char.chr if char
        end while char and WHITESPACE.include? char
        char
      end

    end
  end
end
Faraday.register_middleware :response, parse_json: lambda {
  ActiveCampaign::Response::ParseJson
}