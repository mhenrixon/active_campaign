# frozen_string_literal: true

module ActiveCampaign
  module API
    #
    # Interface to tag endpoints
    #
    # @author Tim Chaston <timchaston@gmail.com>
    #
    module Tags
      #
      # Create a tag
      #
      # @param [Hash] params create a tag with this data
      # @param params [String] :tag Name of the new tag
      # @param params [String] :tagType Tag-type of the new tag. Possible values: template, contact
      # @param params [String] :description Description of the new tag
      #
      # @return [Hash] a hash with the information of the newly created tag
      #
      def create_tag(params)
        post('tags', tag: params)
      end

      #
      # Retrieve a tag
      #
      # @param [Integer] id the id of the tag to retrieve
      #
      # @return [Hash] a hash with the information for the tag
      #
      def show_tag(id)
        get("tags/#{id}")
      end

      #
      # List all tags
      #
      # @option [Hash] params Return results based on this data
      # @option params [Integer] :limit The number of results to display in each page (default = 20; max = 100).
      # @option params [Integer] :offset The starting point for the result set of a page. This is a zero-based index.
      #   For example, if there are 39 total records and the limit is the default of 20, use offset=20 to get the second
      #   page of results.
      #
      # @return [Hash] a hash the information for all tags
      #
      def show_tags(**params)
        get('tags', params)
      end

      #
      # Update a tag
      #
      # @param [Integer] id the id of the tag to update
      # @param [Hash] params update the tag with this data
      # @param params [String] :tag Name for the tag
      # @param params [String] :tagType Tag-type for the tag. Possible values: template, contact
      # @param params [String] :description Description for the tag
      #
      # @return [Hash] a hash with the information for the updated tag
      #
      def update_tag(id, params)
        put("tags/#{id}", tag: params)
      end

      #
      # Delete a tag
      #
      # @param [Integer] id the id of the tag to delete
      #
      # @return [Hash] an empty hash
      #
      def delete_tag(id)
        delete("tags/#{id}")
      end
    end
  end
end
