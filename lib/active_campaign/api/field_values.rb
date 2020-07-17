# frozen_string_literal: true

module ActiveCampaign
  module API
    #
    # Interface to custom field value endpoints
    #
    # @author Tim Chaston <timchaston@gmail.com>
    #
    module FieldValues
      #
      # Create a custom field value
      #
      # @param [Hash] params create a new custom field value with this data
      # @param params [String] :contact ID of the contact whose field value you're updating
      # @param params [String] :field ID of the custom field whose value you're updating for the contact
      # @param params [String] :value Value for the field that you're updating. For multi-select options this needs to be in
      #   the format of ||option1||option2||
      #
      # @return [Hash] a hash with the information of the newly created field value and the contact it was created on
      #
      def create_field_value(params)
        post('fieldValues', fieldValue: params)
      end

      #
      # Retrieve a custom field value
      #
      # @param [Integer] id the id of the custom field value to show
      #
      # @return [Hash] a hash with the information of the custom field value
      #
      def show_field_value(id)
        get("fieldValues/#{id}")
      end

      #
      # Update a custom field value for contact
      #
      # @param [Integer] id the id of the custom field value to update
      # @param [Hash] params update the custom field value with this data
      # @param params [String] :contact the id of the contact whose field value you're updating
      # @param params [String] :field the id of the custom field whose value you're updating for the contact
      # @param params [String] :value the value for the field that you're updating
      #
      # @return [Hash] a hash with the information of the contact and the custom field value
      #
      def update_field_value(id, params)
        put("fieldValues/#{id}", field_value: params)
      end

      #
      # Delete a custom field value
      #
      # @param [Integer] id the id of the custom field value to delete
      #
      # @return [Hash] an empty hash
      #
      def delete_field_value(id)
        delete("fieldValues/#{id}")
      end

      #
      # List all custom field values
      #
      # @option [Hash] filters filter the list of custom field values with this data
      # @option filter [String] :fieldid the id of the field the value belongs to
      # @option filter [String] :val the value of the custom field for a specify contact
      # @option [Hash] params Return results based on this data
      # @option params [Integer] :limit The number of results to display in each page (default = 20; max = 100).
      # @option params [Integer] :offset The starting point for the result set of a page. This is a zero-based index.
      #   For example, if there are 39 total records and the limit is the default of 20, use offset=20 to get the second
      #   page of results.
      #
      # @return [Hash] a hash with the information of field values that match the filters
      def show_field_values(filters: nil, **params)
        params[:filters] = filters if filters

        get('fieldValues', params)
      end
    end
  end
end
