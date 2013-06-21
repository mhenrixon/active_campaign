module ActiveCampaign
  class Client
    module Lists
      LIST_API_METHODS = %w[add delete_list delete edit field_add field_delete field_edit field_view list paginator view]
      LIST_POST_METHODS = %w[add edit]

      extend ActiveSupport::Concern

      # TODO: Create proper methods with parameter validation and possible naming conversion since this is one the worst APIs I have ever worked with.
      included do
        LIST_API_METHODS.each do |method|
          define_method "list_#{method}" do |options|
            if LIST_POST_METHODS.include?(method)
              post __method__, options
            else
              get __method__, options
            end
          end
        end
      end
    end
  end
end