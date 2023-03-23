# frozen_string_literal: true

module ActiveCampaign
  module API
    #
    # Interface for segments API
    #
    # @author Petar Risteski <risteskipetar3@gmail.com>
    #
    module Segments
      #
      # Retrieve a list of segments
      #
      # @return [Hash] a hash with a list of segments
      #
      def segments
        get("segments")
      end

      #
      # Get a single segment
      #
      # @param [Integer] id the id of a segment to show
      #
      # @return [Hash]
      #
      def show_segment(segment_id)
        get("segments", id: segment_id)
      end

    end
  end
end
