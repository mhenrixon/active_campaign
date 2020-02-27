# frozen_string_literal: true

module ActiveCampaign
  module API
    #
    # Interface to user endpoints
    #
    # @author Mikael Henriksson <mikael@mhenrixon.com>
    #
    module Users
      #
      # Create a new user
      #
      # @param [Hash] params create a new user with this data
      # @option params [String] :username Username
      # @option params [String] :email Email address
      # @option params [String] :firstName First name
      # @option params [String] :lastName Last name
      # @option params [Integer] :group Group ID
      # @option params [String] :password Plain text password
      #
      # @return [Hash] a hash with information about the newly created user
      #
      def create_user(params)
        post('users', user: params)
      end

      #
      # Get a single user
      #
      # @param [Integer] id the id of a user to show
      #
      # @return [Hash]
      #
      def show_user(id)
        get("users/#{id}")
      end

      #
      # Get a single user by email
      #
      # @param [String] email the email of a user to show
      #
      # @return [Hash]
      #
      def show_user_by_email(email)
        get("users/email/#{email}")
      end

      #
      # Get a single user by email
      #
      # @param [String] email the email of a user to show
      #
      # @return [Hash]
      #
      def show_user_by_username(username)
        get("users/username/#{username}")
      end

      #
      # Get the currently logged in user
      #
      #
      # @return [Hash]
      #
      def show_user_logged_in
        get('users/me')
      end

      #
      # Get a user of users
      #
      # @param [String] search Filter users that match the given value in the user attributes
      #
      # @return [Array<Hash>]
      #
      def show_users
        get('users')
      end

      #
      # Update an existing user
      #
      # @param [Hash] params create a new user with this data
      # @option params [String] :username Username
      # @option params [String] :email Email address
      # @option params [String] :firstName First name
      # @option params [String] :lastName Last name
      # @option params [Integer] :group Group ID
      # @option params [String] :password Plain text password
      #
      # @return [Hash] a hash with information about the updated user
      #
      def update_user(id, params)
        put("users/#{id}", user: params)
      end

      #
      # Deletes a user with given id
      #
      # @param [String] id the id of a user to delete
      #
      # @return [Hash]
      #
      def delete_user(id)
        delete("users/#{id}")
      end
    end
  end
end
