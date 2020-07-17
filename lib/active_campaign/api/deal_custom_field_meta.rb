# frozen_string_literal: true

module ActiveCampaign
  module API
    #
    # Interface to dealCustomMetum endpoints
    #
    # @author Mikael Henriksson <mikael@mhenrixon.com>
    #
    module DealCustomFieldMeta
      # rubocop:disable Layout/LineLength
      #
      # Create a new dealCustomMetum
      #
      # @param [Hash] params create a new dealCustomMetum with this data
      # @option params [String] field_label Name of the field (required)
      # @option params [String] :field_type Type of field. Possible values are: text, textarea, date, dropdown, multiselect, radio, checkbox, hidden, currency, or number. (required)
      # @option params [Array<String>] :field_options Options for the field. Only necessary if field_type is dropdown, multiselect, radio, or checkbox.
      # @option params [String] :field_default Default value of the field
      # @option params [String] :field_default_currency The 3-letter currency code of the default currency for the field. Only necessary if field_type is currency.
      # @option params [true, false] :is_form_visible Whether or not the field is visible on forms
      # @option params [true, false] :is_required Whether or not the field is required on forms
      # @option params [Integer] :display_order Order for displaying the field on Manage Fields page and deal profiles
      #
      # @return [Hash] a hash with information about the newly created pipeline
      #
      # rubocop:enable Layout/LineLength
      def create_deal_custom_field_meta(params)
        post('dealCustomFieldMeta', deal_custom_field_metum: params)
      end

      #
      # Get a single dealCustomMetum
      #
      # @param [Integer] id the id of a deal to show
      #
      # @return [Hash]
      #
      def show_deal_custom_field_meta(id)
        get("dealCustomFieldMeta/#{id}")
      end

      #
      # Get a list of dealCustomMetum
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
      def show_deal_custom_field_metas(search = nil, **params)
        params[:search] = search

        get('dealCustomFieldMeta', params)
      end

      # rubocop:disable Layout/LineLength
      #
      # Update an existing dealCustomMetum with given id
      #
      # @param [String] id the id of a dealCustomMetum to update
      # @param [Hash] params update the dealCustomMetum with this data
      # @option params [String] field_label Name of the field (required)
      # @option params [Array<String>] :field_options Options for the field. Only necessary if field_type is dropdown, multiselect, radio, or checkbox.
      # @option params [String] :field_default Default value of the field
      # @option params [true, false] :is_form_visible Whether or not the field is visible on forms
      # @option params [true, false] :is_required Whether or not the field is required on forms
      # @option params [Integer] :display_order Order for displaying the field on Manage Fields page and deal profiles
      #
      # @return [Hash] a hash with information about the newly updated dealCustomMetum
      #
      # rubocop:enable Layout/LineLength
      def update_deal_custom_field_meta(id, params)
        put("dealCustomFieldMeta/#{id}", deal_custom_field_meta: params)
      end

      #
      # Move deals to another stage
      #
      # @param [String] id the id of a dealCustomMetum whose deals to move
      # @param [String] stage the id of the new stage
      #
      # @return [Hash]
      #
      def move_deal_custom_field_meta(id, stage)
        put("dealCustomFieldMeta/#{id}/deals", deal: { stage: stage })
      end

      #
      # Deletes a dealCustomMetum with given id
      #
      # @param [String] id the id of a dealCustomMetum to delete
      #
      # @return [Hash]
      #
      def delete_deal_custom_field_meta(id)
        delete("dealCustomFieldMeta/#{id}")
      end
    end
  end
end
