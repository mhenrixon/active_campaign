# frozen_string_literal: true

module ActiveCampaign
  #
  # Base class error for almost all exceptions
  #
  # @author Mikael Henriksson <mikael@zoolutions.se>
  #
  module API
    def self.included(base)
      base.extend(ClassMethods)
    end

    #
    # Extends the base class when {API} is included
    #
    # @author Mikael Henriksson <mikael@zoolutions.se>
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
          require "active_campaign/api/#{endpoint}"

          class_eval do
            include API.const_get(endpoint.to_s.camelize)
          end
        end
      end
    end
  end
end
