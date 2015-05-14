module ActiveCampaign
  class Client
    module Forms
      GET_METHODS = %w(getforms html).freeze unless defined?(GET_METHODS)

      extend ActiveSupport::Concern

      # TODO: Create proper methods with parameter validation and possible
      # naming fixes since this is one the worst APIs I have ever worked with.
      included do
        define_api_calls(:form, GET_METHODS)
      end
    end
  end
end
