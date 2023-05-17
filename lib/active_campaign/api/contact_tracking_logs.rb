# frozen_string_literal: true

module ActiveCampaign
  module API
    #
    # Interface to contact tag endpoints
    #
    # @author Stuart Auld <sja@marsupialmusic.net>
    #
    module ContactTrackingLogs
      #
      # Get tracking logs for a single contact
      #
      # @param [Integer] id the id of a contact to show
      #
      # @return [Hash]
      #
      def show_contact_tracking_logs(id)
        get("contacts/#{id}/trackingLogs")
      end
    end
  end
end
