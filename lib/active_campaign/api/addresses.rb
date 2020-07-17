# frozen_string_literal: true

module ActiveCampaign
  module API
    #
    # Interface to address endpoints
    #
    # @author Mikael Henriksson <mikael@mhenrixon.com>
    #
    module Addresses
      #
      # Create a new address
      #
      # @param [Hash] params create a new address with this data
      # @option params [Integer] :groupid
      # @option params [Object] :global
      # @option params [String] :company_name
      # @option params [String] :address_1 street address line one
      # @option params [String] :address_2 street address line one
      # @option params [String] :city
      # @option params [String] :state
      # @option params [String] :zip
      # @option params [String] :district (Optional for countries that use it)
      # @option params [String] :country Accepts a (2) two character string - country code ISO2 (eg 'US', 'CA', 'MX')
      # @option params [Integer] :allgroup
      # @option params [true, false] :is_default Indicates default address
      #
      # @return [Hash] a hash with information about the newly created address
      #
      def create_address(params)
        post('addresses', address: params, change_case: false)
      end

      #
      # Get a single address
      #
      # @param [Integer] id the id of a address to show
      #
      # @return [Hash]
      #
      def show_address(id)
        get("addresses/#{id}")
      end

      #
      # Get a list of address
      #
      # @option [Hash] params Return results based on this data
      # @option params [Integer] :limit The number of results to display in each page (default = 20; max = 100).
      # @option params [Integer] :offset The starting point for the result set of a page. This is a zero-based index.
      #   For example, if there are 39 total records and the limit is the default of 20, use offset=20 to get the second
      #   page of results.
      #
      # @return [Array<Hash>]
      #
      def show_addresses(**params)
        get('addresses', params)
      end

      #
      # Update an existing address with given id
      #
      # @param [Integer] id the id of a address to update
      # @param [Hash] params create a new address with this data
      # @option params [Integer] :groupid
      # @option params [Object] :global
      # @option params [String] :company_name
      # @option params [String] :address_1 street address line one
      # @option params [String] :address_2 street address line one
      # @option params [String] :city
      # @option params [String] :state
      # @option params [String] :zip
      # @option params [String] :district (Optional for countries that use it)
      # @option params [String] :country Accepts a (2) two character string - country code ISO2 (eg 'US', 'CA', 'MX')
      # @option params [Integer] :allgroup
      # @option params [true, false] :is_default Indicates default address
      #
      # @return [Hash] a hash with information about the newly created address
      #
      def update_address(id, params)
        put("addresses/#{id}", address: params, change_case: false)
      end

      #
      # Deletes a address with given id
      #
      # @param [Integer] id the id of a address to delete
      #
      # @return [Hash]
      #
      def delete_address(id)
        delete("addresses/#{id}")
      end

      #
      # Delete address associated with a specific user group
      #
      # @param [Integer] id the id of a address to delete
      #
      # @return [Hash]
      #
      def delete_address_group(id)
        delete("addressGroups/#{id}")
      end

      #
      # Delete address associated with a specific list
      #
      # @param [Integer] id the id of a address to delete
      #
      # @return [Hash]
      #
      def delete_address_list(id)
        delete("addressGroups/#{id}")
      end
    end
  end
end
