require 'faraday'
require 'multi_json'

# @api private
module Faraday
  class Response::RaiseActiveCampaignError < Response::Middleware
    ERROR_MAP = {
      400 => ActiveCampaign::BadRequest,
      401 => ActiveCampaign::Unauthorized,
      403 => ActiveCampaign::Forbidden,
      404 => ActiveCampaign::NotFound,
      406 => ActiveCampaign::NotAcceptable,
      422 => ActiveCampaign::UnprocessableEntity,
      500 => ActiveCampaign::InternalServerError,
      501 => ActiveCampaign::NotImplemented,
      502 => ActiveCampaign::BadGateway,
      503 => ActiveCampaign::ServiceUnavailable
    }

    def on_complete(response)
      key = response[:status].to_i
      raise ERROR_MAP[key].new(response) if ERROR_MAP.has_key? key
    end
  end
end