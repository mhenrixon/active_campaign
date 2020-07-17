# frozen_string_literal: true

module ActiveCampaign
  module API
    #
    # Interface to group endpoints
    #
    # @author Mikael Henriksson <mikael@mhenrixon.com>
    #
    module Groups
      #
      # Create a new group
      #
      # @param [Hash] params create a new group with this data
      # @option params [String] :title Title of the group to be created
      # @option params [String] :descript Group description
      # @option params [true, false] :pg_message_add Permission for adding messages
      # @option params [true, false] :unsubscribelink Whether or not to force unsubscribe links
      # @option params [true, false] :optinconfirm Whether or not to force optin confirm for this group
      # @option params [true, false] :pg_list_add Permission for adding lists
      # @option params [true, false] :pg_list_edit Permission for editing lists
      # @option params [true, false] :pg_list_delete Permission for deleting lists
      # @option params [true, false] :pg_list_headers Permission for managing custom email headers
      # @option params [true, false] :pg_list_emailaccount Permission for managing Unsubscribe By Email
      # @option params [true, false] :pg_list_bounce Permission for accessing list bounce settings
      # @option params [true, false] :pg_message_edit Permission for editing messages
      # @option params [true, false] :pg_message_delete Permission for deleting messages
      # @option params [true, false] :pg_message_send Permission for sending messages
      # @option params [true, false] :pg_contact_add Permission for adding contacts
      # @option params [true, false] :pg_contact_edit Permission for editing contacts
      # @option params [true, false] :pg_contact_delete Permission for deleting contacts
      # @option params [true, false] :pg_contact_merge Permission for merging contacts
      # @option params [true, false] :pg_contact_import Permission for importing contacts
      # @option params [true, false] :pg_contact_approve Permission for approving contacts
      # @option params [true, false] :pg_contact_export Permission for exporting contacts
      # @option params [true, false] :pg_contact_sync Permission for syncing contacts
      # @option params [true, false] :pg_contact_filters Permission for managing contact list segments
      # @option params [true, false] :pg_contact_actions Permission for managing contact actions
      # @option params [true, false] :pg_contact_fields Permission for managing contact custom fields
      # @option params [true, false] :pg_user_add Permission for adding users
      # @option params [true, false] :pg_user_edit Permission for editing users
      # @option params [true, false] :pg_user_delete Permission for deleting users
      # @option params [true, false] :pg_group_add Permission for adding groups
      # @option params [true, false] :pg_group_edit Permission for editing groups
      # @option params [true, false] :pg_group_delete Permission for deleting groups
      # @option params [true, false] :pg_template_add Permission for adding templates
      # @option params [true, false] :pg_template_edit Permission for editing templates
      # @option params [true, false] :pg_template_delete Permission for deleting templates
      # @option params [true, false] :pg_personalization_add Permission for adding personalization tags
      # @option params [true, false] :pg_personalization_edit Permission for editing personalization tags
      # @option params [true, false] :pg_personalization_delete Permission for deleting personalization tags
      # @option params [true, false] :pg_automation_manage
      # @option params [true, false] :pg_form_edit Permission for editing subscription forms
      # @option params [true, false] :pg_reports_campaign Permission for viewing campaign reports
      # @option params [true, false] :pg_reports_list Permission for viewing list reports
      # @option params [true, false] :pg_reports_user Permission for viewing user reports
      # @option params [true, false] :pg_startup_reports Campaign ID of last campaign report viewed to decide
      #   whether to show link on startup
      # @option params [true, false] :pg_reports_trend Permission for viewing trend reports
      # @option params [true, false] :pg_startup_gettingstarted Whether or not to show the "getting started"
      #   tutorial on overview page
      # @option params [true, false] :pg_deal Permission for viewing deals
      # @option params [true, false] :pg_deal_delete Permission for deleting deals
      # @option params [true, false] :pg_deal_reassign Permission for reassigning deals
      # @option params [true, false] :pg_deal_group_add Permission for adding deal groups
      # @option params [true, false] :pg_deal_group_edit Permission for editing deal groups
      # @option params [true, false] :pg_deal_group_delete Permission for deleting deals groups
      # @option params [true, false] :pg_saved_responses_manage Permission for managing saved responses
      # @option params [true, false] :req_approval Whether or not this group requires all campaigns to be approved
      # @option params [true, false] :req_approval1st Whether or not this group requires first campaign to be approved
      # @option params [String] :req_approval_notify Who to notify for approval related issues (email)
      # @option params [true, false] :socialdata Whether or not to show social links in campaigns sent from this group
      #
      # @return [Hash] a hash with information about the newly created group
      #
      def create_group(params)
        post('groups', group: params)
      end

      #
      # Get a single group
      #
      # @param [Integer] id the id of a group to show
      #
      # @return [Hash]
      #
      def show_group(id)
        get("groups/#{id}")
      end

      #
      # Get a list of groups
      #
      # @param [String] search Filter groups that match the given value in the group attributes
      # @option [Hash] params Return results based on this data
      # @option params [Integer] :limit The number of results to display in each page (default = 20; max = 100).
      # @option params [Integer] :offset The starting point for the result set of a page. This is a zero-based index.
      #   For example, if there are 39 total records and the limit is the default of 20, use offset=20 to get the second
      #   page of results.
      #
      # @return [Array<Hash>]
      #
      def show_groups(search = nil, **params)
        params[:search] = search

        get('groups', params)
      end

      #
      # Update an existing group with given id
      #
      # @param [String] id the id of a group to update
      # @param [Hash] params update an existing group with this data
      # @option params [String] :title Title of the group to be created
      # @option params [String] :descript Group description
      # @option params [true, false] :pg_message_add Permission for adding messages
      # @option params [true, false] :unsubscribelink Whether or not to force unsubscribe links
      # @option params [true, false] :optinconfirm Whether or not to force optin confirm for this group
      # @option params [true, false] :pg_list_add Permission for adding lists
      # @option params [true, false] :pg_list_edit Permission for editing lists
      # @option params [true, false] :pg_list_delete Permission for deleting lists
      # @option params [true, false] :pg_list_headers Permission for managing custom email headers
      # @option params [true, false] :pg_list_emailaccount Permission for managing Unsubscribe By Email
      # @option params [true, false] :pg_list_bounce Permission for accessing list bounce settings
      # @option params [true, false] :pg_message_edit Permission for editing messages
      # @option params [true, false] :pg_message_delete Permission for deleting messages
      # @option params [true, false] :pg_message_send Permission for sending messages
      # @option params [true, false] :pg_contact_add Permission for adding contacts
      # @option params [true, false] :pg_contact_edit Permission for editing contacts
      # @option params [true, false] :pg_contact_delete Permission for deleting contacts
      # @option params [true, false] :pg_contact_merge Permission for merging contacts
      # @option params [true, false] :pg_contact_import Permission for importing contacts
      # @option params [true, false] :pg_contact_approve Permission for approving contacts
      # @option params [true, false] :pg_contact_export Permission for exporting contacts
      # @option params [true, false] :pg_contact_sync Permission for syncing contacts
      # @option params [true, false] :pg_contact_filters Permission for managing contact list segments
      # @option params [true, false] :pg_contact_actions Permission for managing contact actions
      # @option params [true, false] :pg_contact_fields Permission for managing contact custom fields
      # @option params [true, false] :pg_user_add Permission for adding users
      # @option params [true, false] :pg_user_edit Permission for editing users
      # @option params [true, false] :pg_user_delete Permission for deleting users
      # @option params [true, false] :pg_group_add Permission for adding groups
      # @option params [true, false] :pg_group_edit Permission for editing groups
      # @option params [true, false] :pg_group_delete Permission for deleting groups
      # @option params [true, false] :pg_template_add Permission for adding templates
      # @option params [true, false] :pg_template_edit Permission for editing templates
      # @option params [true, false] :pg_template_delete Permission for deleting templates
      # @option params [true, false] :pg_personalization_add Permission for adding personalization tags
      # @option params [true, false] :pg_personalization_edit Permission for editing personalization tags
      # @option params [true, false] :pg_personalization_delete Permission for deleting personalization tags
      # @option params [true, false] :pg_automation_manage
      # @option params [true, false] :pg_form_edit Permission for editing subscription forms
      # @option params [true, false] :pg_reports_campaign Permission for viewing campaign reports
      # @option params [true, false] :pg_reports_list Permission for viewing list reports
      # @option params [true, false] :pg_reports_user Permission for viewing user reports
      # @option params [true, false] :pg_startup_reports Campaign ID of last campaign report viewed to decide
      #   whether to show link on startup
      # @option params [true, false] :pg_reports_trend Permission for viewing trend reports
      # @option params [true, false] :pg_startup_gettingstarted Whether or not to show the "getting started"
      #  tutorial on overview page
      # @option params [true, false] :pg_deal Permission for viewing deals
      # @option params [true, false] :pg_deal_delete Permission for deleting deals
      # @option params [true, false] :pg_deal_reassign Permission for reassigning deals
      # @option params [true, false] :pg_deal_group_add Permission for adding deal groups
      # @option params [true, false] :pg_deal_group_edit Permission for editing deal groups
      # @option params [true, false] :pg_deal_group_delete Permission for deleting deals groups
      # @option params [true, false] :pg_saved_responses_manage Permission for managing saved responses
      # @option params [true, false] :req_approval Whether or not this group requires all campaigns to be approved
      # @option params [true, false] :req_approval1st Whether or not this group requires first campaign to be approved
      # @option params [String] :req_approval_notify Who to notify for approval related issues (email)
      # @option params [true, false] :socialdata Whether or not to show social links in campaigns sent from this group
      #
      # @return [Hash] a hash with information about the newly created group
      #
      #
      # @return [Hash] a hash with information about the newly created group
      #
      def update_group(id, params)
        put("groups/#{id}", group: params)
      end

      #
      # Deletes a group with given id
      #
      # @param [String] id the id of a group to delete
      #
      # @return [Hash]
      #
      def delete_group(id)
        delete("groups/#{id}")
      end

      #
      # Deletes a group with given ids
      #
      # @param [Array<String>] ids a collection of ids to delete
      #
      # @return [Hash]
      #
      def bulk_delete_groups(ids)
        delete('groups/bulk_delete', ids: ids)
      end
    end
  end
end
