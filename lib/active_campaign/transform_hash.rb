# frozen_string_literal: true

require 'active_support/core_ext/string'

module ActiveCampaign
  #
  # Utility module for manipulating hashes, arrays and values
  #
  # @author Mikael Henriksson <mikael@mhenrixon.com>
  #
  module TransformHash
    module_function

    #
    # Transforms case of all hash keys
    # @note this is used to always output a hash response
    #
    # @param [Hash] hash initial hash before transformation
    # @param [Symbol, Symbol] new_case the new case eg. `:underscore` or `:camelcase, :lower`
    #
    # @return [Hash]
    #
    def transform_keys(hash, *new_case)
      hash.each_with_object({}) do |(key, value), memo|
        memo[transform_key(key, *new_case)] = transform_value(value, *new_case)
      end
    end

    #
    # Transform the provided keys case and lastly symbolize it
    #
    # @param [String, Symbol] key the name of the key to change case
    # @param [Symbol, Symbol] new_case the new case eg. `:underscore` or `:camelcase, :lower`
    #
    # @return [Symbol] the transformed key
    #
    def transform_key(key, *new_case)
      key.to_s.public_send(*new_case).to_sym
    end

    #
    # Transform all values
    # @note used for nested values like hashes and arrays
    #
    # @param [Object] value the value to transform
    # @param [Symbol, Symbol] new_case the new case eg. `:underscore` or `:camelcase, :lower`
    #
    # @return [Object]
    #
    def transform_value(value, *new_case)
      case value
      when Hash
        transform_keys(value, *new_case)
      when Array
        transform_array(value, *new_case)
      else
        value
      end
    end

    def transform_array(collection, *new_case)
      collection.map do |element|
        case element
        when Hash
          transform_keys(element, *new_case)
        else
          element
        end
      end
    end
  end
end
