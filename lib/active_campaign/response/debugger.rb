require 'faraday'
require 'forwardable'

module ActiveCampaign
  module Response
    class Debugger < Faraday::Response::Middleware
      extend Forwardable

      def initialize(app, logger = nil)
        super(app)
        @logger = logger || begin
          require 'logger'
          ::Logger.new(STDOUT)
        end
      end

      def_delegators :@logger, :debug, :info, :warn, :error, :fatal

      def call(env)
        info("#{env[:method]} #{env[:url].to_s}")
        debug('request') { dump_headers(env[:request_headers])  + "\nbody: #{env[:body]}" }
        super
      end

      def on_complete(env)
        info('Status') { env[:status].to_s }
        debug('response-head') { dump_headers env[:response_headers] }
        debug('response-body') { env[:body] }
      end

      private

      def dump_headers(headers)
        headers.map { |k, v| "#{k}: #{v.inspect}" }.join("\n")
      end
    end
  end
end

Faraday.register_middleware :middleware, debugger: lambda {
  ActiveCampaign::Response::Debugger
}