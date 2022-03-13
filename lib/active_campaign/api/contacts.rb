# frozen_string_literal: true

module ActiveCampaign
  module API
    #
    # Interface to contact endpoints
    #
    # @author Mikael Henriksson <mikael@mhenrixon.com>
    #
    module Contacts
      #
      # Create a new contact
      #
      # @param [Hash] params create a new contact with this data
      # @option params [String] :email the contacts email
      # @option params [String] :first_name the first name of the contact
      # @option params [String] :last_name the last name of the contact
      # @option params [String] :phone the number to call the contact with
      #
      # @return [Hash] a hash with information about the newly created contact
      #
      def create_contact(params)
        post('contacts', contact: params)
      end

      #
      # Get a single contact
      #
      # @param [Integer] id the id of a contact to show
      #
      # @return [Hash]
      #
      def show_contact(id)
        get("contacts/#{id}")
      end

      #
      # Sync an existing contact or create a new one
      #
      # @param [Hash] params create a new contact with this data
      # @option params [String] :email the contacts email
      # @option params [String] :first_name the first name of the contact
      # @option params [String] :last_name the last name of the contact
      # @option params [String] :phone the number to call the contact with
      #
      # @return [Hash] a hash with information about the newly created contact
      #
      def sync_contact(params)
        post('contact/sync', contact: params)
      end

      #
      # Get a list of contacts
      #
      # @param [Hash] params
      # @option params param [String] :ids Filter contacts by ID. Can be repeated for multiple IDs.
      #   Example: ids: [42, 43, 1]
      # @option params [Date] :datetime Contacts created on the specified date
      # @option params [String] :email Email address of the contact you want to get
      # @option params [String] :email_like Filter contacts that contain the given value in the email address
      # @option params [Integer] :exclude Exclude from the response the contact with the given ID
      # @option params [Integer] :formid Filter contacts associated with the given form
      # @option params [Integer] :id_greater Only include contacts with an ID greater than the given ID
      # @option params [Integer] :id_less Only include contacts with an ID less than the given ID
      # @option params [String] :listid Filter contacts associated with the given list
      # @option params [String] :search Filter contacts that match the given value in the contact attributes
      # @option params [Integer] :segmentid Return only contacts that match a list segment
      # @option params [Integer] :seriesid Filter contacts associated with the given automation
      # @option params [Integer] :status See available values
      # @option params [Integer] :tagid Filter contacts associated with the given tag
      # @option params [Integer] :limit The number of results to display in each page (default = 20; max = 100).
      # @option params [Integer] :offset The starting point for the result set of a page. This is a zero-based index.
      #   For example, if there are 39 total records and the limit is the default of 20, use offset=20 to get the second
      #   page of results.
      #
      # @param [Hash] filters a list of filters
      # @option filters [Date] :created_before Filter contacts that were created prior to this date
      # @option filters [Date] :created_after Filter contacts that were created after this date
      # @option filters [Date] :updated_before Filter contacts that were updated before this date
      # @option filters [String] :updated_after Filter contacts that were updated after this date
      # @option filters [Integer] :waitid Filter by contacts in the wait queue of an automation block
      # @param [Hash] orders a list of filters by orders
      # @option orders [String] :cdate Order contacts by creation date
      # @option orders [String] :email Order contacts by email
      # @option orders [String] :first_name Order contacts by first name
      # @option orders [String] :last_name Order contacts by last name
      # @option orders [String] :name Order contacts by full name
      # @option orders [String] :score Order contacts by score
      # @option orders [String] :in_group_lists "true" to return only contacts the user has permissions to see.
      #
      # @return [Hash]
      #
      def show_contacts(filters: {}, orders: {}, **params)
        params[:filters] = filters if filters.any?
        params[:orders]  = orders  if orders.any?

        get('contacts', params)
      end

      #
      # Deletes a contact with given id
      #
      # @param [Integer] id the id of a contact to delete
      #
      # @return [Hash]
      #
      def delete_contact(id)
        delete("contacts/#{id}")
      end

      #
      # Update an existing contact with given id
      #
      # @param [Integer] id the id of a contact to update
      # @param [Hash] params create a new contact with this data
      # @option params [String] :email the contacts email
      # @option params [String] :first_name the first name of the contact
      # @option params [String] :last_name the last name of the contact
      # @option params [String] :phone the number to call the contact with
      #
      # @return [Hash] a hash with information about the newly created contact
      #
      def update_contact(id, params)
        put("contacts/#{id}", contact: params)
      end
    end
  end
end
