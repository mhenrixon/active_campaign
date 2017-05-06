# frozen_string_literal: true

module ActiveCampaign
  class Client
    module Contacts
      #
      # POST methods
      #
      def contact_add(options = {})
        post __method__, options
      end
      alias subscriber_add contact_add

      def contact_edit(options = {})
        post __method__, options
      end
      alias subscriber_edit contact_edit

      def contact_sync(options = {})
        post __method__, options
      end
      alias subscriber_sync contact_sync

      def contact_tag_add(options = {})
        post __method__, options
      end
      alias subscriber_tag_add contact_tag_add

      def contact_tag_remove(options = {})
        post __method__, options
      end
      alias subscriber_tag_remove contact_tag_remove

      def contact_note_edit(options = {})
        post __method__, options
      end
      alias subscriber_note_edit contact_note_edit

      def contact_note_add(options = {})
        post __method__, options
      end
      alias subscriber_note_add contact_note_add

      #
      # GET methods
      #
      def contact_automation_list(options = {})
        get __method__, options
      end
      alias subscriber_automation_list contact_automation_list

      def contact_delete_list(options = {})
        get __method__, options
      end
      alias subscriber_delete_list contact_delete_list

      def contact_delete(options = {})
        get __method__, options
      end
      alias subscriber_delete contact_delete

      def contact_list(options = {})
        get __method__, options
      end
      alias subscriber_list contact_list

      def contact_paginator(options = {})
        get __method__, options
      end
      alias subscriber_paginator contact_paginator

      def contact_view(options = {})
        get __method__, options
      end
      alias subscriber_view contact_view

      def contact_view_email(options = {})
        get __method__, options
      end
      alias subscriber_view_email contact_view_email

      def contact_view_hash(options = {})
        get __method__, options
      end
      alias subscriber_view_hash contact_view_hash

      def contact_note_delete(options = {})
        get __method__, options
      end
      alias subscriber_note_delete contact_note_delete
    end
  end
end
