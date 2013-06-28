require 'faraday_middleware'
require 'faraday/response/raise_active_campaign_error'
require 'faraday/response/body_logger'
require 'faraday/response/json_normalizer'

module ActiveCampaign

  # @private
  module Connection
    private

    def connection(options={})
      options = {
        force_urlencoded: true,
        raw:              false
      }.merge(options)

      if !proxy.nil?
        options.merge!(proxy: proxy)
      end

      # TODO: Don't build on every request
      connection = Faraday.new(options) do |conn|

        if options[:force_urlencoded]
          conn.request :url_encoded
        else
          conn.request :json
        end


        conn.use Faraday::Response::RaiseActiveCampaignError
        conn.use FaradayMiddleware::FollowRedirects
        if api_output == 'json'
          conn.response :mashify, content_type: /\bjson$/
          conn.response :json_normalizer
          conn.response :json, content_type: /\bjson$/
        end
        faraday_config_block.call(conn) if faraday_config_block
        if log_requests
          conn.response :body_logger
          conn.use :instrumentation
        end

        conn.adapter *adapter
      end

      connection.headers[:user_agent] = user_agent
      connection
    end
  end
end