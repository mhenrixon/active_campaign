require 'multi_json'

module ActiveCampaign
  module Request

    def delete(api_method, options={})
      request(:delete, api_method, options).body
    end

    def get(api_method, options={})
      request(:get, api_method, options).body
    end

    def patch(api_method, options={})
      request(:patch, api_method, options).body
    end

    def post(api_method, options={})
      request(:post, api_method, options).body
    rescue => e
      puts e, e.backtrace
    end

    def put(api_method, options={})
      request(:put, api_method, options).body
    end

    private

      # Executes the request, checking if it was successful
      #
      # @return [Boolean] True on success, false otherwise
      def boolean_from_response(method, api_method, options={})
       request(method, api_method, options).status == 204
      rescue ActiveCampaign::NotFound
        false
      end

      def path(api_method)
        "#{api_path}?#{url_params(api_method).map{|k,v| "#{k}=#{v}" }.join('&')}"
      end

      def url_params(api_method, options = {})
        params = {
          api_key: api_key,
          api_action: api_method,
          api_output: api_output,
        }

        if listid = options.delete(:list_id) { nil }
          params.merge!({ listid: listid  })
        end

        params
      end

      def request(method, api_method, options={})

        options.stringify_keys!

        force_urlencoded = options.delete(:force_urlencoded) || false
        url = options.delete(:endpoint) || api_endpoint

        conn_options = {
          :force_urlencoded => force_urlencoded,
          :url => url
        }

        response = connection(conn_options).send(method) do |request|
          case method
          when :get, :delete, :head
            options.reverse_merge!(url_params(api_method, options))
            request.url(api_path, options)
          when :patch, :post, :put
            request.url(api_path, url_params(api_method, options))
            if force_urlencoded
              request.body = options unless options.empty?
            else
              request.body = MultiJson.dump(options) unless options.empty?
            end
          end

          if ActiveCampaign.request_host
            request.headers['Host'] = ActiveCampaign.request_host
          end

        end
        response
      end

  end
end