# frozen_string_literal: true

module ActiveCampaign
  class Client
    module Deals
      GET_METHODS ||= %w[get list pipeline_list stage_list].freeze

      POST_METHODS ||= %w[
        add delete edit note_add note_edit pipeline_add pipeline_delete
        pipeline_edit stage_add stage_delete stage_edit task_add task_edit
        tasktype_add tasktype_delete tasktype_edit
      ].freeze

      # TODO: Create proper methods with parameter validation and possible
      # naming fixes since this is one the worst APIs I have ever worked with.
      def self.included(base)
        base.class_exec do
          define_api_calls(:deal, GET_METHODS, POST_METHODS)
        end
      end
    end
  end
end
