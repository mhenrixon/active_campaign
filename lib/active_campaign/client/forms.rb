# frozen_string_literal: true

module ActiveCampaign
  class Client
    module Forms
      GET_METHODS ||= %w[getforms html].freeze

      # TODO: Create proper methods with parameter validation and possible
      # naming fixes since this is one the worst APIs I have ever worked with.
      def self.included(base)
        base.class_exec do
          define_api_calls(:form, GET_METHODS)
        end
      end
    end
  end
end
