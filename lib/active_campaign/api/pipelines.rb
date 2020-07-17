# frozen_string_literal: true

module ActiveCampaign
  module API
    #
    # Interface to pipline endpoints (dealGroups)
    #
    # @author Mikael Henriksson <mikael@mhenrixon.com>
    #
    module Pipelines
      # rubocop:disable Layout/LineLength
      #
      # Create a new pipeline (dealGroup)
      #
      # @param [Hash] params create a new pipeline with this data
      # @option params [String] :title Pipeline's title.
      # @option params [String] :currency Default currency to assign to new deals that belong to this deal group.
      # @option params [Integer] :allgroups Whether all user groups have permission to manage this pipeline. Can be either 1 or 0. If 1, all user groups can manage this pipeline. If 0, only user groups in dealGroup.groups parameter can manage this pipeline.
      # @option params [Integer] :allusers Whether new deals get auto-assigned to all users. Can be either 1 or 0. If 1, new deals are auto-assigned to all users unless auto-assign is disabled. If 0, new deals are auto-assigned to only the users in dealGroup.users parameter.
      # @option params [Integer] :autoassign Deal auto-assign option. Can be one of 0, 1, and 2. If 0, auto-assign is disabled. If 1, Round Robin method is used to auto-assign new deals. If 2, deals are distributed based on deal values.
      # @option params [Array<String>] :users List of user ids to auto-assign new deals to unless auto-assign option is disabled.
      # @option params [Array<String>] :groups List of user group ids to allow managing this pipeline.
      #
      # @return [Hash] a hash with information about the newly created pipeline
      #
      # rubocop:enable Layout/LineLength
      def create_pipeline(params)
        post('dealGroups', deal_group: params)
      end
      alias create_deal_group create_pipeline

      #
      # Get a single pipeline (dealGroup)
      #
      # @param [Integer] id the id of a deal to show
      #
      # @return [Hash]
      #
      def show_pipeline(id)
        get("dealGroups/#{id}")
      end
      alias show_deal_group show_pipeline

      #
      # Get a list of pipelines (dealGroups)
      #
      # @param [String] search Filter pipelines that match the given value in the pipeline attributes
      # @option [Hash] params Return results based on this data
      # @option params [Integer] :limit The number of results to display in each page (default = 20; max = 100).
      # @option params [Integer] :offset The starting point for the result set of a page. This is a zero-based index.
      #   For example, if there are 39 total records and the limit is the default of 20, use offset=20 to get the second
      #   page of results.
      #
      # @return [Array<Hash>]
      #
      def show_pipelines(search = nil, **params)
        params[:search] = search

        get('dealGroups', params)
      end
      alias show_deal_groups show_pipelines

      # rubocop:disable Layout/LineLength
      #
      # Update an existing pipeline (dealGroup) with given id
      #
      # @param [String] id the id of a pipeline to update
      # @param [Hash] params create a new pipeline with this data
      # @option params [String] :title Pipeline's title.
      # @option params [String] :currency Default currency to assign to new deals that belong to this deal group.
      # @option params [Integer] :allgroups Whether all user groups have permission to manage this pipeline. Can be either 1 or 0. If 1, all user groups can manage this pipeline. If 0, only user groups in dealGroup.groups parameter can manage this pipeline.
      # @option params [Integer] :allusers Whether new deals get auto-assigned to all users. Can be either 1 or 0. If 1, new deals are auto-assigned to all users unless auto-assign is disabled. If 0, new deals are auto-assigned to only the users in dealGroup.users parameter.
      # @option params [Integer] :autoassign Deal auto-assign option. Can be one of 0, 1, and 2. If 0, auto-assign is disabled. If 1, Round Robin method is used to auto-assign new deals. If 2, deals are distributed based on deal values.
      # @option params [Array<String>] :users List of user ids to auto-assign new deals to unless auto-assign option is disabled.
      # @option params [Array<String>] :groups List of user group ids to allow managing this pipeline.
      #
      # @return [Hash] a hash with information about the newly updated pipeline
      #
      # rubocop:enable Layout/LineLength
      def update_pipeline(id, params)
        put("dealGroups/#{id}", deal_group: params)
      end
      alias update_deal_group update_pipeline

      #
      # Deletes a pipeline (dealGroup) with given id
      #
      # @param [String] id the id of a pipeline to delete
      #
      # @return [Hash]
      #
      def delete_pipeline(id)
        delete("dealGroups/#{id}")
      end
      alias delete_deal_group delete_pipeline
    end
  end
end
