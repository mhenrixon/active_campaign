# frozen_string_literal: true

module ActiveCampaign
  class Client
    module Lists
      #
      # POST methods
      #

      def list_add(options = {})
        post __method__, options
      end

      def list_edit(options = {})
        post __method__, options
      end

      def list_field_add(options = {})
        post __method__, options
      end

      def list_field_edit(options = {})
        post __method__, options
      end

      #
      # GET methods
      #

      def list_delete_list(options = {})
        get __method__, options
      end

      def list_delete(options = {})
        get __method__, options
      end

      def list_field_delete(options = {})
        get __method__, options
      end

      def list_field_view(options = {})
        get __method__, options
      end

      def list_list(options = {})
        get __method__, options
      end

      def list_paginator(options = {})
        get __method__, options
      end

      def list_view(options = {})
        get __method__, options
      end
    end
  end
end
