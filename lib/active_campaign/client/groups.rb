module ActiveCampaign
  class Client
    module Groups
      GET_METHODS = %w(
        delete delete_list list view
      ).freeze unless defined?(GET_METHODS)

      POST_METHODS = %w(add edit) unless defined?(POST_METHODS)

      extend ActiveSupport::Concern

      # TODO: Create proper methods with parameter validation and possible
      # naming fixes since this is one the worst APIs I have ever worked with.
      included do
        define_api_calls(:group, GET_METHODS, POST_METHODS)
      end
    end
  end
end
