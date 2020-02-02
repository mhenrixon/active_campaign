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
      # @option params [String] :name the name of the group
      # @option params [String] :group_url the address of the groups website
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
      #
      # @return [Array<Hash>] <description>
      #
      def show_groups(search = nil)
        get('groups', search: search)
      end

      #
      # Update an existing group with given id
      #
      # @param [String] id the id of a group to update
      # @param [Hash] params create a new group with this data
      # @option params [String] :name the name of the group
      # @option params [String] :group_url the address of the groups website
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
