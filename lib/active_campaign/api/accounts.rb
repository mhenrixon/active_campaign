# frozen_string_literal: true

module ActiveCampaign
  module API
    #
    # Interface to account endpoints
    #
    # @author Mikael Henriksson <mikael@mhenrixon.com>
    #
    module Accounts
      #
      # Create a new account
      #
      # @param [Hash] params create a new account with this data
      # @option params [String] :name the name of the account
      # @option params [String] :account_url the address of the accounts website
      #
      # @return [Hash] a hash with information about the newly created account
      #
      def create_account(params)
        post('accounts', account: params)
      end

      #
      # Get a single account
      #
      # @param [Integer] id the id of a account to show
      #
      # @return [Hash]
      #
      def show_account(id)
        get("accounts/#{id}")
      end

      #
      # Get a list of accounts
      #
      # @param [String] search Filter accounts that match the given value in the account attributes
      #
      # @return [Array<Hash>] <description>
      #
      def show_accounts(search = nil)
        get('accounts', search: search)
      end

      #
      # Update an existing account with given id
      #
      # @param [String] id the id of a account to update
      # @param [Hash] params create a new account with this data
      # @option params [String] :name the name of the account
      # @option params [String] :account_url the address of the accounts website
      #
      # @return [Hash] a hash with information about the newly created account
      #
      def update_account(id, params)
        put("accounts/#{id}", account: params)
      end

      #
      # Deletes a account with given id
      #
      # @param [String] id the id of a account to delete
      #
      # @return [Hash]
      #
      def delete_account(id)
        delete("accounts/#{id}")
      end

      #
      # Deletes a account with given ids
      #
      # @param [Array<String>] ids a collection of ids to delete
      #
      # @return [Hash]
      #
      def bulk_delete_accounts(ids)
        delete('accounts/bulk_delete', ids: ids)
      end
    end
  end
end
