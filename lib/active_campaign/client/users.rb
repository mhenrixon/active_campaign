# frozen_string_literal: true

module ActiveCampaign
  class Client
    module Users
      #
      # POST methods
      #

      def user_add(options = {})
        post __method__, options
      end

      def user_edit(options = {})
        post __method__, options
      end

      #
      # GET methods
      #

      def user_delete(options = {})
        get __method__, options
      end

      def user_delete_list(options = {})
        get __method__, options
      end

      def user_list(options = {})
        get __method__, options
      end

      def user_me(options = {})
        get __method__, options
      end

      def user_view(options = {})
        get __method__, options
      end

      def user_view_email(options = {})
        get __method__, options
      end

      def user_view_username(options = {})
        get __method__, options
      end
    end
  end
end
