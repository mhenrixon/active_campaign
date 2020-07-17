# frozen_string_literal: true

module ActiveCampaign
  module API
    #
    # Interface to dealStage endpoints
    #
    # @author Mikael Henriksson <mikael@mhenrixon.com>
    #
    module DealStages
      # rubocop:disable Layout/LineLength
      #
      # Create a new dealStage
      #
      # @param [Hash] params create a new dealStage with this data
      # @option params [String] :title Deal stage's title (required)
      # @option params [String] :group Deal stage's pipeline id (required)
      # @option params [Integer] :order Order of the deal stage. If more than one deal stage share the same order value, the order of those deal stages may not be always the same. If dealStage.order is not provided, the order is assigned with (the highest order of deal stages within the same pipeline) + 1
      # @option params [String] :deal_order Option and direction to be used to sort deals in the deal stage. The option and direction should be delimited by a space. Direction can be either "ASC" or "DESC". See available options
      # @option params [String] :card_region_1 What to show in upper-left corner of Deal Cards. See available values
      # @option params [String] :card_region_2 What to show in upper-right corner of Deal Cards. See available values
      # @option params [String] :card_region_3 Whether to show the avatar in Deal Cards. Can be one of show-avatar and hide-avatar. If set to show-avatar, deal cards will show the avatars. If set to hide-avatar, deal cards will hide the avatars
      # @option params [String] :card_region_4 What to show next to the avatar in Deal Cards. See available values
      # @option params [String] :card_region_5 What to show in lower-right corner of Deal Cards. See available values
      # @option params [String] :color Deal Stage's color. 6-character HEX color code without the hashtag. e.g. "434343" to assign the hex color value "#434343"
      # @option params [Integer] :width Deal stage's width in pixels, without px unit
      #
      # @return [Hash] a hash with information about the newly created pipeline
      #
      # rubocop:enable Layout/LineLength
      def create_deal_stage(params)
        post('dealStages', deal_stage: params)
      end

      #
      # Get a single dealStage
      #
      # @param [Integer] id the id of a deal to show
      #
      # @return [Hash]
      #
      def show_deal_stage(id)
        get("dealStages/#{id}")
      end

      #
      # Get a list of pipelines (dealStages)
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
      def show_deal_stages(search = nil, **params)
        params[:search] = search

        get('dealStages', search: search)
      end

      # rubocop:disable Layout/LineLength
      #
      # Update an existing dealStage with given id
      #
      # @param [String] id the id of a dealStage to update
      # @param [Hash] params create a new dealStage with this data
      # @option params [String] :title Deal stage's title (required)
      # @option params [String] :group Deal stage's pipeline id (required)
      # @option params [Integer] :order Order of the deal stage. If more than one deal stage share the same order value, the order of those deal stages may not be always the same. If dealStage.order is not provided, the order is assigned with (the highest order of deal stages within the same pipeline) + 1
      # @option params [String] :deal_order Option and direction to be used to sort deals in the deal stage. The option and direction should be delimited by a space. Direction can be either "ASC" or "DESC"
      # @option params [String] :card_region_1 What to show in upper-left corner of Deal Cards. See available values
      # @option params [String] :card_region_2 What to show in upper-right corner of Deal Cards. See available values
      # @option params [String] :card_region_3 Whether to show the avatar in Deal Cards. Can be one of show-avatar and hide-avatar. If set to show-avatar, deal cards will show the avatars. If set to hide-avatar, deal cards will hide the avatars
      # @option params [String] :card_region_4 What to show next to the avatar in Deal Cards. See available values
      # @option params [String] :card_region_5 What to show in lower-right corner of Deal Cards. See available values
      # @option params [String] :color 6-character HEX color code without the hashtag. e.g. "434343" to assign the hex color value "#434343"
      # @option params [Integer] :width width in pixels, without px unit
      #
      # @return [Hash] a hash with information about the newly created pipeline
      #
      # @return [Hash] a hash with information about the newly updated pipeline
      #
      # rubocop:enable Layout/LineLength
      def update_deal_stage(id, params)
        put("dealStages/#{id}", deal_stage: params)
      end

      #
      # Move deals to another stage
      #
      # @param [String] id the id of a dealStage whose deals to move
      # @param [String] stage the id of the new stage
      #
      # @return [Hash]
      #
      def move_deal_stage(id, stage)
        put("dealStages/#{id}/deals", deal: { stage: stage })
      end

      #
      # Deletes a dealStage with given id
      #
      # @param [String] id the id of a dealStage to delete
      #
      # @return [Hash]
      #
      def delete_deal_stage(id)
        delete("dealStages/#{id}")
      end
    end
  end
end
