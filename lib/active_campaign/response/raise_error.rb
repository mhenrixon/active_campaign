require 'faraday'
require 'active_campaign/error'

module ActiveCampaign
  # Faraday response middleware
  module Response

    # This class raises an ActiveCampaign-flavored exception based
    # HTTP status codes returned by the API
    class RaiseError < Faraday::Response::Middleware

      private

      def on_complete(response)
        if error = ActiveCampaign::Error.from_response(response)
          raise error
        end
      end
    end
  end
end
Faraday.register_middleware :response, raise_error: lambda {
  ActiveCampaign::Response::RaiseError
}