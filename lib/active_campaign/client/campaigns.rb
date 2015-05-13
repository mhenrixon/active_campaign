module ActiveCampaign
  class Client
    module Campaigns
      CONTACT_METHODS = %w(
        create delete_list delete list paginator report_bounce_list
        report_bounce_totals report_forward_list report_forward_totals
        report_link_list report_link_totals report_open_list report_open_totals
        report_totals report_unopen_list report_unsubscription_list
        report_unsubscription_totals send status
      )
      CONTACT_POST_METHODS = %w(create)

      extend ActiveSupport::Concern

      # TODO: Create proper methods with parameter validation and possible
      #       naming fixes since this is one the worst APIs I have ever worked with.
      included do
        CONTACT_METHODS.each do |method|
          define_method "campaign_#{method}" do |options|
            if CONTACT_POST_METHODS.include?(method)
              post __method__, options
            else
              get __method__, options
            end
          end
        end
      end
    end
  end
end
