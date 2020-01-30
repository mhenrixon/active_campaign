# frozen_string_literal: true

require_relative 'middleware/request'
require_relative 'middleware/response'

module ActiveCampaign
  module Faraday
    #
    # Utility functions for managing Faraday middlewares
    #
    # @author Mikael Henriksson <mikael@zoolutions.se>
    #
    module Middleware
      def self.add_request_middleware(faraday, config = {})
        faraday.request :active_campaign,
                        'Accept' => 'application/json',
                        'Content-Type' => 'application/json',
                        'Api-Token' => config[:api_token],
                        'User-Agent' => "ActiveCampaign Ruby Client (v#{ActiveCampaign::VERSION})"

        return unless (middleware = config[:request_middleware])
        return if middleware.none?

        middleware.each do |key, options|
          faraday.request key, options unless key.to_s.empty?
        end
      end

      def self.add_response_middleware(faraday, middleware = {})
        faraday.response :active_campaign

        return if middleware.none?

        middleware.each do |key, **options|
          next if key.to_s.empty?

          add_middleware(faraday, key, options)
        end
      end

      def self.add_middleware(faraday, key, options)
        if options.is_a?(Hash) && options.any?
          faraday.response key, options
        else
          faraday.response key
        end
      end
    end
  end
end
