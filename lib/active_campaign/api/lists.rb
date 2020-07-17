# frozen_string_literal: true

module ActiveCampaign
  module API
    #
    # Interface to list endpoints
    #
    # @author Mikael Henriksson <mikael@mhenrixon.com>
    #
    module Lists
      #
      # Create a new list
      #
      # @param [Hash] params create a new list with this data
      # @option params [String] :name REQUIRED Name of the list to create
      # @option params [String] :stringid REQUIRED URL-safe list name. Example: 'list-name-sample'
      # @option params [String] :sender_url REQUIRED The website URL this list is for.
      # @option params [String] :sender_reminder REQUIRED A reminder for your contacts as to why
      #   they are on this list and you are messaging them
      # @option params [true, false] :send_last_broadcast Boolean value indicating whether or
      #   not to send the last sent campaign to this list to a new subscriber upon subscribing. 1 = yes, 0 = no
      # @option params [String] :carboncopy Comma-separated list of email addresses to send a
      #   copy of all mailings to upon send
      # @option params [String] :subscription_notify Comma-separated list of email addresses to notify
      #   when a new subscriber joins this list
      # @option params [String] :unsubscription_notify Comma-separated list of email addresses to notify
      #   when a subscriber unsubscribes from this list
      # @option params [Integer] :user User Id of the list owner. A list owner is able to control campaign branding.
      #   A property of list.userid also exists on this object; both properties map to the same list owner field and
      #   are being maintained in the response object for backward compatibility. If you post values for both
      #   list.user and list.userid, the value of list.user will be used.
      #
      # @return [Hash] a hash with information about the newly created list
      #
      def create_list(params)
        post('lists', list: params)
      end

      #
      # Get a single list
      #
      # @param [Integer] id the id of a list to show
      #
      # @return [Hash]
      #
      def show_list(id)
        get("lists/#{id}")
      end

      #
      # Get a list of lists
      #
      # @param [String] search Filter lists that match the given value in the list attributes
      # @option [Hash] params Return results based on this data
      # @option params [Integer] :limit The number of results to display in each page (default = 20; max = 100).
      # @option params [Integer] :offset The starting point for the result set of a page. This is a zero-based index.
      #   For example, if there are 39 total records and the limit is the default of 20, use offset=20 to get the second
      #   page of results.
      #
      # @return [Array<Hash>]
      #
      def show_lists(search = nil, **params)
        params[:search] = search

        get('lists', params)
      end

      #
      # Deletes a list with given id
      #
      # @param [String] id the id of a list to delete
      #
      # @return [Hash]
      #
      def delete_list(id)
        delete("lists/#{id}")
      end
    end
  end
end
