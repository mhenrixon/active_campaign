# frozen_string_literal: true

module ActiveCampaign
  class Client
    module Groups
      def group_delete(options = {})
        get __method__, options
      end

      def group_delete_list(options = {})
        get __method__, options
      end

      def group_list(options = {})
        get __method__, options
      end

      def group_view(options = {})
        get __method__, options
      end

      def group_add(options = {})
        post __method__, options
      end

      def group_edit(options = {})
        post __method__, options
      end
    end
  end
end
