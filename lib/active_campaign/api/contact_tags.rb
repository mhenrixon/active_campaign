# frozen_string_literal: true

module ActiveCampaign
  module API
    #
    # Interface to contact tag endpoints
    #
    # @author Tim Chaston <timchaston@gmail.com>
    #
    module ContactTags
      #
      # Add a tag to a contact
      #
      # @param [Hash] params add a tag to a contact with this data
      # @param params [String] :contact ID of the contact you're adding the tag to
      # @param params [String] :tag ID of the tag to be added for the contact
      #
      # @return [Hash] a hash with the information of the newly created contact tag
      #
      def create_contact_tag(params)
        post('contactTags', contact_tag: params)
      end

      #
      # Remove a tag from a contact
      #
      # @param [Integer] id the id of the contact tag to delete
      #
      # @return [Hash] an empty hash
      #
      def delete_contact_tag(id)
        delete("contactTags/#{id}")
      end

      # NOTE: Undocumented functionality
      #
      # Retrieve contact tags for a contact
      #
      # @param [Integer] id the id of the contact to retrieve contact tags for
      # @option [Hash] params Return results based on this data
      # @option params [Integer] :limit The number of results to display in each page (default = 20; max = 100).
      # @option params [Integer] :offset The starting point for the result set of a page. This is a zero-based index.
      #   For example, if there are 39 total records and the limit is the default of 20, use offset=20 to get the second
      #   page of results.
      #
      # @return [Hash] a hash with the information of all contact tags of the contact
      #
      def show_contact_contact_tags(id, **params)
        get("contacts/#{id}/contactTags", params)
      end

      # NOTE: Undocumented functionality
      #
      # Retrieve a contact tag
      #
      # @return [Hash] a hash with the information of the contact tag
      #
      def show_contact_tag(id)
        get("contactTags/#{id}")
      end

      # NOTE: Undocumented functionality
      #
      # Retrieve a list of all contact tags
      #
      # @option [Hash] params Return results based on this data
      # @option params [Integer] :limit The number of results to display in each page (default = 20; max = 100).
      # @option params [Integer] :offset The starting point for the result set of a page. This is a zero-based index.
      #   For example, if there are 39 total records and the limit is the default of 20, use offset=20 to get the second
      #   page of results.
      #
      # @return [Hash] a hash with the information of all contact tags
      #
      def show_contact_tags(**params)
        get('contactTags', params)
      end
    end
  end
end
