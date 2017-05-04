# frozen_string_literal: true

module ActiveCampaign
  class Client
    module Users
      GET_METHODS ||= %w[delete delete_list list me view view_email view_username].freeze
      POST_METHODS ||= %w[add edit].freeze

      # TODO: Create proper methods with parameter validation and possible naming
      #       fixes since this is one the worst APIs I have ever worked with.
      def self.included(base)
        base.class_exec do
          define_api_calls(:user, GET_METHODS, POST_METHODS)
        end
      end
    end
  end
end
