# frozen_string_literal: true

module ActiveCampaign
  class Client
    module Messages
      GET_METHODS ||= %w[
        delete_list delete list template_add template_delete_list
        template_delete template_edit template_export template_import
        template_list template_view view
      ].freeze

      POST_METHODS ||= %w[add edit].freeze

      # TODO: Create proper methods with parameter validation and possible
      # naming fixes since this is one the worst APIs I have ever worked with.
      def self.included(base)
        base.class_exec do
          define_api_calls(:message, GET_METHODS, POST_METHODS)
        end
      end
    end
  end
end
