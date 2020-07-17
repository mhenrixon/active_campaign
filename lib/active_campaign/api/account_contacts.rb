# frozen_string_literal: true

module ActiveCampaign
  module API
    #
    # Interface to account contact endpoints
    #
    # @author Mikael Henriksson <mikael@mhenrixon.com>
    #
    module AccountContacts
      #
      # Create a new account contact
      #
      # @param [Hash] params create a new account contact with this data
      # @option params [String] :contact the id of the contact
      # @option params [String] :account the id of the account
      # @option params [String] :job_title job title of the account contact
      #
      # @return [Hash] a hash with information about the newly created account
      #
      def create_account_contact(params)
        post('accountContacts', account_contact: params)
      end

      #
      # Get a single account contact
      #
      # @param [Integer] id the id of a account to show
      #
      # @return [Hash]
      #
      def show_account_contact(id)
        get("accountContacts/#{id}")
      end

      #
      # Get a list of account contacts
      #
      # @param [String] search Filter account contacts that match the given value in the account attributes
      # @option [Hash] params Return results based on this data
      # @option params [Integer] :limit The number of results to display in each page (default = 20; max = 100).
      # @option params [Integer] :offset The starting point for the result set of a page. This is a zero-based index.
      #   For example, if there are 39 total records and the limit is the default of 20, use offset=20 to get the second
      #   page of results.
      #
      # @return [Array<Hash>]
      #
      def show_account_contacts(search = nil, **params)
        params[:search] = search

        get('accountContacts', params)
      end

      #
      # Update an existing account contact with given id
      #
      # @param [String] id the id of a account contact to update
      # @param [Hash] params create a new account contact with this data
      # @option params [String] :contact the id of the contact
      # @option params [String] :account the id of the account
      # @option params [String] :job_title job title of the account contact
      #
      # @return [Hash] a hash with information about the newly created account contact
      #
      def update_account_contact(id, params)
        put("accountContacts/#{id}", account_contact: params)
      end

      #
      # Deletes a account contact with given id
      #
      # @param [String] id the id of a account contact to delete
      #
      # @return [Hash]
      #
      def delete_account_contact(id)
        delete("accountContacts/#{id}")
      end
    end
  end
end
