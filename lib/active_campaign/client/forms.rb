# frozen_string_literal: true

module ActiveCampaign
  class Client
    module Forms
      def form_getforms(options = {})
        get(__method__, options)
      end

      def form_html(options = {})
        get(__method__, options)
      end
    end
  end
end
