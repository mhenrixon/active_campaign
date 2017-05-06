# frozen_string_literal: true

module ActiveCampaign
  class Client
    module Tracks
      #
      # POST methods
      #

      def track_event_status_edit(options = {})
        post __method__, options
      end

      def track_site_status_edit(options = {})
        post __method__, options
      end

      def track_event_add(options = {})
        post __method__, options
      end

      #
      # PUT methods
      #

      def track_site_whitelist_add(options = {})
        put __method__, options
      end

      #
      # GET methods
      #

      def track_event_list(options = {})
        get __method__, options
      end

      def track_site_list(options = {})
        get __method__, options
      end

      #
      # DELETE methods
      #

      def track_event_delete(options = {})
        delete __method__, options
      end

      def track_site_whitelist_delete(options = {})
        delete __method__, options
      end
    end
  end
end
