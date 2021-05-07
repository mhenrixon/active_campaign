# frozen_string_literal: true

module ActiveCampaign
  module API
    #
    # Interface to accountCustomMetum endpoints
    #
    # @author Mikael Henriksson <mikael@mhenrixon.com>
    #
    module AccountCustomFieldData
      # rubocop:disable Layout/LineLength
      #
      # Create a new accountCustomMetum
      #
      # @param [Hash] params create a new accountCustomMetum with this data
      # @option params [String] field_label Name of the field (required)
      # @option params [String] :field_type Type of field. Possible values are: text, textarea, date, dropdown, multiselect, radio, checkbox, hidden, currency, or number. (required)
      # @option params [Array<String>] :field_options Options for the field. Only necessary if field_type is dropdown, multiselect, radio, or checkbox.
      # @option params [String] :field_default Default value of the field
      # @option params [String] :field_default_currency The 3-letter currency code of the default currency for the field. Only necessary if field_type is currency.
      # @option params [true, false] :is_form_visible Whether or not the field is visible on forms
      # @option params [true, false] :is_required Whether or not the field is required on forms
      # @option params [Integer] :display_order Order for displaying the field on Manage Fields page and account profiles
      #
      # @return [Hash] a hash with information about the newly created pipeline
      #
      # rubocop:enable Layout/LineLength
      def create_account_custom_field_data(params)
        post('accountCustomFieldData', account_custom_field_metum: params)
      end

      #
      # Get a single accountCustomMetum
      #
      # @param [Integer] id the id of a account to show
      #
      # @return [Hash]
      #
      def show_account_custom_field_data(id)
        get("accountCustomFieldData/#{id}")
      end

      #
      # Get a list of accountCustomMetum
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
      def show_account_custom_field_datas(search = nil, **params)
        params[:search] = search

        get('accountCustomFieldData', params)
      end

      # rubocop:disable Layout/LineLength
      #
      # Update an existing accountCustomMetum with given id
      #
      # @param [String] id the id of a accountCustomMetum to update
      # @param [Hash] params update the accountCustomMetum with this data
      # @option params [String] field_label Name of the field (required)
      # @option params [Array<String>] :field_options Options for the field. Only necessary if field_type is dropdown, multiselect, radio, or checkbox.
      # @option params [String] :field_default Default value of the field
      # @option params [true, false] :is_form_visible Whether or not the field is visible on forms
      # @option params [true, false] :is_required Whether or not the field is required on forms
      # @option params [Integer] :display_order Order for displaying the field on Manage Fields page and account profiles
      #
      # @return [Hash] a hash with information about the newly updated accountCustomMetum
      #
      # rubocop:enable Layout/LineLength
      def update_account_custom_field_data(id, params)
        put("accountCustomFieldData/#{id}", account_custom_field_data: params)
      end

      #
      # Move accounts to another stage
      #
      # @param [String] id the id of a accountCustomMetum whose accounts to move
      # @param [String] stage the id of the new stage
      #
      # @return [Hash]
      #
      def move_account_custom_field_data(id, stage)
        put("accountCustomFieldData/#{id}/accounts", account: { stage: stage })
      end

      #
      # Deletes a accountCustomMetum with given id
      #
      # @param [String] id the id of a accountCustomMetum to delete
      #
      # @return [Hash]
      #
      def delete_account_custom_field_data(id)
        delete("accountCustomFieldData/#{id}")
      end
    end
  end
end
