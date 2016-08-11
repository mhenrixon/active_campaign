module ActiveCampaign
  class Client
    module Groups
      GET_METHODS ||= %w(
        delete delete_list list view
      ).freeze

      POST_METHODS ||= %w(add edit).freeze

      # TODO: Create proper methods with parameter validation and possible
      # naming fixes since this is one the worst APIs I have ever worked with.
      def self.included(base)
        base.class_exec do
          define_api_calls(:group, GET_METHODS, POST_METHODS)
        end
      end
    end
  end
end
