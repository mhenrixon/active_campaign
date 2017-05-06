# frozen_string_literal: true

module ActiveCampaign
  class Client
    module Campaigns
      #
      # POST methods
      #
      def campaign_edit(options = {})
        post __method__, options
      end

      def campaign_create(options = {})
        post __method__, options
      end

      #
      # GET methods
      #
      def campaign_delete_list(options = {})
        get __method__, options
      end

      def campaign_delete(options = {})
        get __method__, options
      end

      def campaign_list(options = {})
        get __method__, options
      end

      def campaign_paginator(options = {})
        get __method__, options
      end

      def campaign_report_bounce_list(options = {})
        get __method__, options
      end

      def campaign_report_bounce_totals(options = {})
        get __method__, options
      end

      def campaign_report_forward_list(options = {})
        get __method__, options
      end

      def campaign_report_forward_totals(options = {})
        get __method__, options
      end

      def campaign_report_link_list(options = {})
        get __method__, options
      end

      def campaign_report_link_totals(options = {})
        get __method__, options
      end

      def campaign_report_open_list(options = {})
        get __method__, options
      end

      def campaign_report_open_totals(options = {})
        get __method__, options
      end

      def campaign_report_totals(options = {})
        get __method__, options
      end

      def campaign_report_unopen_list(options = {})
        get __method__, options
      end

      def campaign_report_unsubscription_list(options = {})
        get __method__, options
      end

      def campaign_report_unsubscription_totals(options = {})
        get __method__, options
      end

      def campaign_send(options = {})
        get __method__, options
      end

      def campaign_status(options = {})
        get __method__, options
      end
    end
  end
end
