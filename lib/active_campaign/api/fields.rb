# frozen_string_literal: true

module ActiveCampaign
  module API
    #
    # Interface to custom field endpoints
    #
    # @author Tim Chaston <timchaston@gmail.com>
    #
    module Fields
      #
      # Create a custom field
      #
      # @param [Hash] params create a custom field with this data
      # @param params [String] :title the title of the field being created
      # @param params [String] :type possible values: dropdown, hidden, checkbox, date, text, textarea, NULL, listbox, radio
      # @option params [String] :descript description of the field being
      # @option params [true, false] :isrequired dictates whether the field being created is required or not
      # @option params [String] :perstag the perstag that represents the field being created
      # @option params [String] :defval the default value of the field being created
      # @option params [true, false] :show_in_list show this field in the contact list view (deprecated - no longer used)
      # @option params [Integer] :rows the number of rows for a textarea (deprecated - no longer used)
      # @option params [Integer] :cols the number of columns for a textarea (deprecated - no longer used)
      # @option params [true, false] :visible show or hide this field when using the Form Builder
      # @option params [String] :service possible values: nimble, contactually, mindbody, salesforce, highrise,
      #   google_spreadsheets, pipedrive, onepage, google_contacts, freshbooks, shopify, zendesk, etsy, NULL,
      #   bigcommerce, capsule, bigcommerce_oauth, sugarcrm, zohocrm, batchbook
      # @option params [Integer] :ordernum order of appearance in 'My Fields' tab
      #
      # @return [Hash] a hash with information about all custom fields, including the newly created custom field
      def create_field(params)
        post('fields', field: params)
      end

      #
      # Retrieve a custom field
      #
      # @param [Integer] id the id of the custom field to show
      #
      # @return [Hash]
      def show_field(id)
        get("fields/#{id}")
      end

      #
      # Update a custom field
      #
      # @param [Integer] id the id of the field to update
      # @param [Hash] params update the custom field with this data
      # @option params [String] :title the title of the field being created
      # @option params [String] :type possible values: dropdown, hidden, checkbox, date, text, textarea, NULL, listbox, radio
      # @option params [String] :descript description of the field being
      # @option params [true, false] :isrequired dictates whether the field being created is required or not
      # @option params [String] :perstag the perstag that represents the field being created
      # @option params [String] :defval the default value of the field being created
      # @option params [true, false] :show_in_list show this field in the contact list view (deprecated - no longer used)
      # @option params [Integer] :rows the number of rows for a textarea (deprecated - no longer used)
      # @option params [Integer] :cols the number of columns for a textarea (deprecated - no longer used)
      # @option params [true, false] :visible show or hide this field when using the Form Builder
      # @option params [String] :service possible values: nimble, contactually, mindbody, salesforce, highrise,
      #   google_spreadsheets, pipedrive, onepage, google_contacts, freshbooks, shopify, zendesk, etsy, NULL,
      #   bigcommerce, capsule, bigcommerce_oauth, sugarcrm, zohocrm, batchbook
      # @option params [Integer] :ordernum order of appearance in 'My Fields' tab
      #
      # @return [Hash]
      def update_field(id, params)
        put("fields/#{id}", field: params)
      end

      #
      # Delete a custom field
      #
      # @param [Integer] id the id of the custom field to show
      #
      # @return [Hash]
      def delete_field(id)
        delete("fields/#{id}")
      end

      #
      # List all custom fields
      # @option [Hash] params Return results based on this data
      # @option params [Integer] :limit The number of results to display in each page (default = 20; max = 100).
      # @option params [Integer] :offset The starting point for the result set of a page. This is a zero-based index.
      #   For example, if there are 39 total records and the limit is the default of 20, use offset=20 to get the second
      #   page of results.
      #
      # @return [Hash] a hash with information on all custom fields
      def show_fields(**params)
        get('fields', params)
      end

      #
      # Create a custom field relationship to list(s)
      #
      # @param [Hash] params create a relationship with this data
      # @param params [Integer] :field the id of the field to create the relationship
      # @param params [Integer] :relid the id of the list to create the relationship (0 makes the field available
      #   on all lists)
      #
      # @return [Hash]
      def create_field_rel(params)
        post('fieldRels', fieldRel: params)
      end

      # NOTE: Undocumented functionality
      #
      # Show a field rel
      #
      # @param [Integer] id the id of the field rel to show
      #
      # @return [Hash]
      def show_field_rel(id)
        get("fieldRels/#{id}")
      end

      # NOTE: Undocumented functionality
      #
      # Delete a custom field relationship
      #
      # @param [Integer] id the id of the field rel to delete
      #
      # @return [Hash]
      def delete_field_rel(id)
        delete("fieldRels/#{id}")
      end

      #
      # Create custom field options
      #
      # @param [Array<Hash>] options an array of option hashes
      # @param options [Hash] params create an option with this data
      # @param params [Integer] :field the id of the custom field to add options to
      # @option params [String] :label the name of the option
      # @param params [String] :value the value of the option
      # @option params [Integer] :orderid the order for displaying the custom field option
      # @option params [true, false] :isdefault whether or not this option is the default value
      #
      # @return [Hash] a hash containing information on the newly created field option
      def create_field_options(params)
        post('fieldOption/bulk', fieldOptions: params)
      end

      # NOTE: Undocumented functionality.
      #
      # Retrieve a custom field option
      #
      # @param [Integer] id the id of the custom field option to show
      #
      # @return [Hash]
      def show_field_option(id)
        get("fieldOptions/#{id}")
      end

      # NOTE: Undocumented functionality.
      #
      # Delete a custom field option
      #
      # @param [Integer] id the id of the custom field option to delete
      #
      # @return [Hash]
      def delete_field_option(id)
        delete("fieldOptions/#{id}")
      end
    end
  end
end
