module ActiveCampaign
  class Client
    module Lists
      GET_METHODS = %w(
        delete_list delete field_delete
        field_view list paginator view
      ).freeze unless defined?(GET_METHODS)
      POST_METHODS = %w(
        add edit field_add field_edit
      ).freeze unless defined?(POST_METHODS)
      DELETE_METHODS = [].freeze unless defined?(DELETE_METHODS)

      extend ActiveSupport::Concern

      included do
        define_api_calls(:list, GET_METHODS, POST_METHODS, DELETE_METHODS)
      end
    end
  end
end
