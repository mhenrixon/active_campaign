# frozen_string_literal: true

module ActiveCampaign
  module Faraday
    module Middleware
      #
      # Gem specific request middleware for Faraday
      #
      # @author Mikael Henriksson <mikael@zoolutions.se>
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
          body = transform_keys(body, :camelcase, :lower)
          env[:request_body] = ::Oj.dump(body, mode: :compat)
        end
      end
    end
  end
end

Faraday::Request.register_middleware active_campaign: ActiveCampaign::Faraday::Middleware::Request
