# frozen_string_literal: true

module ActiveCampaign
  module API
    #
    # Interface to contact list endpoints
    #
    # @author Daniel Moreira <danieldenis01@gmail.com>
    #
    module ContactLists
      #
      # Subscribe a contact to a list or unsubscribe a contact from a list
      #
      # @param [Hash] params add a contact to a list with this data
      # @param params [String] :contact ID of the contact you're adding the tag to
      # @param params [String] :list ID of the list to subscribe the contact to
      # @param params [String] :status Set to "1" to subscribe or "2" to unsubscribe.
      #
      # @return [Hash] a hash with the information of the newly created contact list
      #
      def update_contact_list(params)
        post('contactLists', contact_list: params)
      end
    end
  end
end
