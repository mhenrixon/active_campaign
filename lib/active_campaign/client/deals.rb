# frozen_string_literal: true

module ActiveCampaign
  class Client
    module Deals
      def deal_get(options = {})
        get __method__, options
      end

      def deal_list(options = {})
        get __method__, options
      end

      def deal_pipeline_list(options = {})
        get __method__, options
      end

      def deal_stage_list(options = {})
        get __method__, options
      end

      def deal_add(options = {})
        post __method__, options
      end

      def deal_delete(options = {})
        post __method__, options
      end

      def deal_edit(options = {})
        post __method__, options
      end

      def deal_note_add(options = {})
        post __method__, options
      end

      def deal_note_edit(options = {})
        post __method__, options
      end

      def deal_pipeline_add(options = {})
        post __method__, options
      end

      def deal_pipeline_delete(options = {})
        post __method__, options
      end

      def deal_pipeline_edit(options = {})
        post __method__, options
      end

      def deal_stage_add(options = {})
        post __method__, options
      end

      def deal_stage_delete(options = {})
        post __method__, options
      end

      def deal_stage_edit(options = {})
        post __method__, options
      end

      def deal_task_add(options = {})
        post __method__, options
      end

      def deal_task_edit(options = {})
        post __method__, options
      end

      def deal_tasktype_add(options = {})
        post __method__, options
      end

      def deal_tasktype_delete(options = {})
        post __method__, options
      end

      def deal_tasktype_edit(options = {})
        post __method__, options
      end
    end
  end
end
