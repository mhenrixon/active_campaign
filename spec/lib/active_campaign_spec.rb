# frozen_string_literal: true

require 'spec_helper'

describe ActiveCampaign do
  # rubocop:disable LineLength
  unless defined?(API_CALLS)
    API_CALLS = %w[
      campaign_create campaign_delete campaign_delete_list campaign_list campaign_paginator campaign_report_bounce_list campaign_report_bounce_totals campaign_report_forward_list campaign_report_forward_totals campaign_report_link_list campaign_report_link_totals campaign_report_open_list campaign_report_open_totals campaign_report_totals campaign_report_unopen_list campaign_report_unsubscription_list campaign_report_unsubscription_totals campaign_send campaign_status
      contact_add contact_automation_list contact_delete contact_delete_list contact_edit contact_list contact_note_add contact_note_delete contact_note_edit contact_paginator contact_sync contact_tag_add contact_tag_remove contact_view contact_view_email contact_view_hash
      deal_add deal_delete deal_edit deal_get deal_list deal_note_add deal_note_edit deal_pipeline_add deal_pipeline_delete deal_pipeline_edit deal_pipeline_list deal_stage_add deal_stage_delete deal_stage_edit deal_stage_list deal_task_add deal_task_edit deal_tasktype_add deal_tasktype_delete deal_tasktype_edit
      form_getforms form_html
      group_add group_delete group_delete_list group_edit group_list group_view
      list_add list_delete list_delete_list list_edit list_field_add list_field_delete list_field_edit list_field_view list_list list_paginator list_view
      message_add message_delete message_delete_list message_edit message_list message_template_add message_template_delete message_template_delete_list message_template_edit message_template_export message_template_import message_template_list message_template_view message_view
      user_add user_delete user_delete_list user_edit user_list user_me user_view user_view_email user_view_username
      track_event_delete track_event_list track_event_status_edit track_site_list track_site_status_edit track_site_whitelist_add track_site_whitelist_delete track_event_add
    ].freeze
  end
  # rubocop:enable LineLength

  before do
    ActiveCampaign.reset!
  end

  after do
    ActiveCampaign.reset!
  end

  describe 'api_calls' do
    API_CALLS.each do |call|
      specify { expect(ActiveCampaign).to respond_to(call) }
    end
  end

  describe '.client' do
    it 'creates an ActiveCampaign::Client' do
      expect(ActiveCampaign.client).to be_kind_of ActiveCampaign::Client
    end

    it 'caches the client when the same options are passed' do
      expect(ActiveCampaign.client).to eq ActiveCampaign.client
    end

    it 'returns a fresh client when options are not the same' do
      client = ActiveCampaign.client
      ActiveCampaign.config.api_key = 'somekey'
      client_two = ActiveCampaign.client
      client_three = ActiveCampaign.client
      expect(client_three).to eql client_two
      expect(client).to_not eql client_two
    end
  end

  describe '.configure' do
    ActiveCampaign.config.to_h.keys.each do |key|
      it "sets the #{key.to_s.tr('_', ' ')}" do
        ActiveCampaign.configure do |config|
          config.send("#{key}=", key)
        end
        expect(ActiveCampaign.config.send(key)).to eq key
      end
    end
  end
end
