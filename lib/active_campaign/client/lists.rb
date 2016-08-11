module ActiveCampaign
  class Client
    module Lists
      GET_METHODS ||= %w(
        delete_list delete field_delete
        field_view list paginator view
      ).freeze
      POST_METHODS ||= %w(
        add edit field_add field_edit
      ).freeze
      DELETE_METHODS ||= [].freeze

      def self.included(base)
        base.class_exec do
          define_api_calls(:list, GET_METHODS, POST_METHODS, DELETE_METHODS)
        end
      end
    end
  end
end
