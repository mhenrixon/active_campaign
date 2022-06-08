# frozen_string_literal: true

module ActiveCampaign
  module API
    #
    # Interface to contact lists endpoints
    #
    # @author Drago Crnjac <drago@sparkloop.app>
    #
    module ContactLists
      #
      # Add contact to the list
      #
      # @param [Hash] params add contact to the list with this data
      # @option params [String] :list ID of the list to subscribe the contact to
      # @option params [String] :contact ID of the contact to subscribe to the list
      # @option params [String] :status Set to "1" to subscribe the contact to the list. Set to "2" to unsubscribe the contact from the list. WARNING: If you change a status from unsubscribed to active, you can re-subscribe a contact to a list from which they had manually unsubscribed.
      # @option params [Integer] :sourceid Set to "4" when re-subscribing a contact to a list
      #
      # @return [Hash] a hash with information about the newly added contact to the list
      #
      def create_contact_list(params)
        post('contactLists', contact_list: params)
      end

    end
  end
end
