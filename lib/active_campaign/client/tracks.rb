module ActiveCampaign
  class Client
    module Tracks
      GET_METHODS = %w(event_list site_list).freeze unless defined?(GET_METHODS)
      PUT_METHODS = %w(site_whitelist_add).freeze unless defined?(PUT_METHODS)
      POST_METHODS = %w(
        event_status_edit site_status_edit event_add
      ).freeze unless defined?(POST_METHODS)
      DELETE_METHODS = %w(
        event_delete site_whitelist_delete
      ).freeze unless defined?(DELETE_METHODS)

      extend ActiveSupport::Concern

      # TODO: Create proper methods with parameter validation and possible
      # naming fixes since this is one the worst APIs I have ever worked with.
      included do
        define_api_calls(:track, GET_METHODS, POST_METHODS, DELETE_METHODS, PUT_METHODS)
      end
    end
  end
end
