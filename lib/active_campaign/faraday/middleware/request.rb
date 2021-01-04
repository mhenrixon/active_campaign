# frozen_string_literal: true

module ActiveCampaign
  module Faraday
    module Middleware
      #
      # Gem specific request middleware for Faraday
      #
      # @author Mikael Henriksson <mikael@mhenrixon.com>
      #
      class Request < ::Faraday::Middleware
        dependency 'oj'

        include TransformHash

        def initialize(app, headers)
          super(app)
          @headers = headers
        end

        def call(env)
          case env.method
          when :post, :patch, :put
            normalize_body(env)
          end

          env[:request_headers].merge!(@headers)
          @app.call(env)
        end

        def normalize_body(env)
          body = env[:request_body]
          if body.is_a?(Array)
            body = transform_array(body.flatten, :camelcase, :lower)
          elsif body.key?(:group)
            logger.debug("Using body as is because group #{body}")
          elsif body.key?(:list)
            logger.debug("Using body as is because list #{body}")
          else
            body = transform_keys(body, :camelcase, :lower)
          end

          env[:request_body] = ::Oj.dump(body, mode: :compat)
        end

        def logger
          @logger ||= Logger.new(STDOUT)
        end
      end
    end
  end
end

Faraday::Request.register_middleware active_campaign: ActiveCampaign::Faraday::Middleware::Request
