require 'json'

module ConstructorIO
  class Client
    def add(params)
      call_api("item", "post", params)
    end

    def remove(params)
      call_api("item", "delete", params)
    end

    def modify(params)
      call_api("item", "put", params)
    end

    def track_search(params)
      call_api("search", "post", params)
    end

    def track_click_through(params)
      call_api("click_through", "post", params)
    end

    def track_conversion(params)
      call_api("conversion", "post", params)
    end

    def verify
      call_api("verify", "get")
    end

    private

    def call_api(path, method, params)
      api_token = ConstructorIO.configuration.api_token
      api_url = ConstructorIO.configuration.api_url || "https://ac.constructor.io/"
      autocomplete_key = ConstructorIO.configuration.autocomplete_key
      @http_client ||= Faraday.new(url: api_url)
      @http_client.basic_auth(api_token, '')

      send_request(path, method, @http_client, params, autocomplete_key)
    end

    def send_request(path, method, http_client, params, autocomplete_key)
      response = http_client.send(method) do |request|
        request.url "/v1/#{path}?autocomplete_key=#{autocomplete_key}"
        request.headers['Content-Type'] = 'application/json'
        request.body = params.to_json
      end
      if response.status.to_s =~ /^2/
        return nil
      else
        return response.status
      end
    end
  end
end