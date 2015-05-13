require 'active_support'

module ActiveCampaign
  class Client
    module Contacts
      CONTACT_METHODS = %w(
      CONTACT_METHODS = %w(
        add automation_list delete_list delete edit list paginator 
        sync view view_email view_hash tag_add tag_remove
      )
      CONTACT_POST_METHODS = %w(add edit sync tag_add tag_remove)

      extend ActiveSupport::Concern

      # TODO: Create proper methods with parameter validation and possible naming fixes since
      #       this is one the worst APIs I have ever worked with.
      included do
        %w(contact subscriber).each do |name|
          CONTACT_METHODS.each do |method|
            define_method "#{name}_#{method}" do |options|
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
end
