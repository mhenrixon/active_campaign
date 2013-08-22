require 'faraday'
require 'faraday/response'

module ActiveCampaign
  module Response
    class JsonNormalizer < Faraday::Response::Middleware
      def initialize(app, logger = nil)
        super(app)
      end

      def call(environment)
        @app.call(environment).on_complete do |env|
          if env[:body].is_a?(Hash)
            env[:body] = normalize(env[:body])
          end
        end
      end

      private

        def normalize(response)
          keys, values = keys_values(response)

          if keys.all?{|key| is_numeric?(key) }
            response[:results] = values
            keys.each do |key|
              response.delete(key)
            end
          end

          response
        end

        def is_numeric?(string)
          string.to_s.match(/\A[+-]?\d+\Z/) == nil ? false : true
        end

        def keys_values(response)
          results = results(response)
          [results.keys, results.values]
        end

        def results(response)
          response.reject{|k,v| %w(result_code result_message result_output).include?(k) }
        end
    end
  end
end
Faraday.register_middleware :response, json_normalizer: lambda { ActiveCampaign::Response::JsonNormalizer }