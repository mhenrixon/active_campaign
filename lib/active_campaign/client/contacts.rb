module ActiveCampaign
  class Client
    module Contacts
      GET_METHODS ||= %w(
        automation_list delete_list delete list paginator view view_email
        view_hash note_delete
      ).freeze

      POST_METHODS ||= %w(
        add edit sync tag_add tag_remove
        note_edit note_add
      ).freeze

      # TODO: Create proper methods with parameter validation and possible naming
      #       fixes since this is one the worst APIs I have ever worked with.
      def self.included(base)
        base.class_exec do
          %w(contact subscriber).each do |name|
            define_api_calls(name, GET_METHODS, POST_METHODS)
          end
        end
      end
    end
  end
end
