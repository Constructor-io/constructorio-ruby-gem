module ConstructorIO
  class Client
    def add(params)
      self.call_api("post", params)
    end

    def remove(params)
      self.call_api("delete", params)
    end

    private

    def self.call_api(method, params)
      api_token = ConstructorIO.configuration.api_token
      api_url = ConstructorIO.configuration.api_url || "https://ac.constructor.io/"
      autocomplete_key = ConstructorIO.configuration.autocomplete_key
      @http_client ||= Faraday.new(url: api_url)
      @http_client.basic_auth(api_token, '')

      send_request(method, @http_client, params, autocomplete_key)
    end

    def self.send_request(method, http_client, params, autocomplete_key)
      response = http_client.send(method) do |request|
        request.url "/v1/item?autocomplete_key=#{autocomplete_key}"
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
