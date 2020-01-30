# frozen_string_literal: true

module ActiveCampaign
  module API
    #
    # Interface to account endpoints
    #
    # @author Mikael Henriksson <mikael@mhenrixon.com>
    #
    module AccountContacts
      #
      # Create a new account
      #
      # @param [Hash] params create a new account with this data
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
      # Get a single account
      #
      # @param [Integer] id the id of a account to show
      #
      # @return [Hash]
      #
      def show_account_contact(id)
        get("accountContacts/#{id}")
      end

      #
      # Get a list of accounts
      #
      # @param [String] search Filter accounts that match the given value in the account attributes
      #
      # @return [Array<Hash>]
      #
      def show_account_contacts(search = nil)
        get('accountContacts', search: search)
      end

      #
      # Update an existing account with given id
      #
      # @param [String] id the id of a account to update
      # @param [Hash] params create a new account with this data
      # @option params [String] :contact the id of the contact
      # @option params [String] :account the id of the account
      # @option params [String] :job_title job title of the account contact
      #
      # @return [Hash] a hash with information about the newly created account
      #
      def update_account_contact(id, params)
        put("accountContacts/#{id}", account_contact: params)
      end

      #
      # Deletes a account with given id
      #
      # @param [String] id the id of a account to delete
      #
      # @return [Hash]
      #
      def delete_account_contact(id)
        delete("accountContacts/#{id}")
      end
    end
  end
end
