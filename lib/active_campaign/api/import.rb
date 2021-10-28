# frozen_string_literal: true

module ActiveCampaign
  module API
    #
    # Interface to account endpoints
    #
    # @author Mikael Henriksson <mikael@mhenrixon.com>
    #
    module Import
      #
      # Create a new bulk import
      #
      # @param [Hash] params create a new bulk import with this data
      #
      # @return [Hash] a hash with information about the newly created bulk import
      #
      def bulk_import(params)
        post('import/bulk_import', contacts: params)
      end

      #
      # Get a single bulk import
      #
      # @param [Integer] id the id of an import to show
      #
      # @return [Hash]
      #
      def show_import_batch(batchId)
        get("import/info", batchId: batchId)
      end

    end
  end
end
