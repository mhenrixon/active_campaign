require 'active_support'

module ActiveCampaign
  class Client
    module Users
      GET_METHODS = %w(
        delete delete_list list me view view_email view_username
      ).freeze unless defined?(GET_METHODS)

      POST_METHODS = %w(add edit).freeze unless defined?(POST_METHODS)

      extend ActiveSupport::Concern

      # TODO: Create proper methods with parameter validation and possible naming
      #       fixes since this is one the worst APIs I have ever worked with.
      included do
        define_api_calls(:user, GET_METHODS, POST_METHODS)
      end
    end
  end
end
