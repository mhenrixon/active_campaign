# frozen_string_literal: true

module ActiveCampaign
  #
  # Base class error for almost all exceptions
  #
  # @author Mikael Henriksson <mikael@mhenrixon.com>
  #
  module API
    def self.included(base)
      base.extend(ClassMethods)
    end

    #
    # Extends the base class when {API} is included
    #
    # @author Mikael Henriksson <mikael@mhenrixon.com>
    #
    module ClassMethods
      #
      # Utility method to avoid some duplication for requiring files and including
      #
      # @param [Array<Symbol>] endpoints an array of endpoints to include `:users`
      #
      # @return [void]
      #
      def endpoints(*endpoints)
        endpoints.each do |endpoint|
          endpoint(endpoint)
        end
      end

      #
      # Utility method to avoid some duplication for requiring files and including API modules
      #
      # @param [Symbol] endpoint an endpoint to include example: `:users`
      #
      # @return [void]
      #
      def endpoint(endpoint)
        require "active_campaign/api/#{endpoint}"

        class_eval { include API.const_get(endpoint.to_s.camelize) }
      rescue LoadError, NameError
        raise DependencyMissing, endpoint
      end

      # rubocop:disable ThreadSafety/InstanceVariableInClassMethod

      #
      # Memoized logger for convenience
      #
      #
      # @return [Logger] any object that responds to :debug, :info, :warn, :error and :fatal
      #
      def logger
        @logger ||= ActiveCampaign.logger
      end

      # rubocop:enable ThreadSafety/InstanceVariableInClassMethod
    end
  end
end
