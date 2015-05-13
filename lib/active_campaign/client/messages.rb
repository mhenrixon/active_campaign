module ActiveCampaign
  class Client
    module Messages
      CONTACT_METHODS = %w(
        add delete_list delete edit list template_add template_delete_list
        template_delete template_edit template_export template_import
        template_list template_view view
      )
      CONTACT_POST_METHODS = %w(add edit)

      extend ActiveSupport::Concern

      # TODO: Create proper methods with parameter validation and possible
      # naming fixes since this is one the worst APIs I have ever worked with.
      included do
        CONTACT_METHODS.each do |method|
          define_method "contact_#{method}" do |options|
            if CONTACT_POST_METHODS.include?(method)
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
