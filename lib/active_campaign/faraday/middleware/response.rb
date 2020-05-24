# frozen_string_literal: true

require 'logger'
require 'faraday/logging/formatter'

module ActiveCampaign
  LOGGER = ::Logger.new(STDOUT)
  module Faraday
    module Middleware
      #
      # Gem specific response middleware for Faraday
      #
      # @author Mikael Henriksson <mikael@mhenrixon.com>
      #
      class Response < ::Faraday::Response::Middleware
        dependency 'oj'

        include TransformHash

        # Override this to modify the environment after the response has finished.
        # Calls the `parse` method if defined
        def on_complete(env)
          env.body = parse(env.body)
          debug(env) if ActiveCampaign.config.debug?
        end

        def parse(body)
          return body if body.to_s.empty?

          body = ::Oj.load(body, mode: :compat)
          transform_keys(body, :underscore)
        end

        def debug(env)
          formatter.request(env)
          formatter.response(env)
        end

        def formatter
          @formatter ||= ::Faraday::Logging::Formatter.new(
            logger: LOGGER,
            options: { headers: true, bodies: true }
          )
        end
      end
    end
  end
end

Faraday::Response.register_middleware active_campaign: ActiveCampaign::Faraday::Middleware::Response
