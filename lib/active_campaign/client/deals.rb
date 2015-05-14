module ActiveCampaign
  class Client
    module Deals
      GET_METHODS = %w(get list pipeline_list stage_list).freeze unless defined?(GET_METHODS)

      POST_METHODS = %w(
        add delete edit note_add note_edit pipeline_add pipeline_delete
        pipeline_edit stage_add stage_delete stage_edit task_add task_edit
        tasktype_add tasktype_delete tasktype_edit
      ).freeze unless defined?(POST_METHODS)

      extend ActiveSupport::Concern

      # TODO: Create proper methods with parameter validation and possible
      # naming fixes since this is one the worst APIs I have ever worked with.
      included do
        define_api_calls(:deal, GET_METHODS, POST_METHODS)
      end
    end
  end
end
