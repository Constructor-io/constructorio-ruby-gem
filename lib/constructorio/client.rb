require 'json'

module ConstructorIO
  class Client

    attr_accessor :local_configuration

    def initialize(config = nil)
      @local_configuration = config || ConstructorIO::Configuration.new(
        api_token: ConstructorIO.configuration.api_token,
        api_url: ConstructorIO.configuration.api_url || "https://ac.cnstrc.com/",
        autocomplete_key: ConstructorIO.configuration.autocomplete_key
      )
    end

    def add(params)
      call_api("item", "post", params)
    end

    def add_or_update(params)
      call_api("item", "put", params, {force: 1})
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

    def add_batch(params)
      call_api("batch_items", "post", params)
    end

    def add_or_update_batch(params)
      call_api("batch_items", "put", params, {force: 1})
    end

    def remove_batch(params)
      call_api("batch_items", "delete", params)
    end

    private

    def call_api(path, method, params = {}, additional_query_params = {})
      api_token = self.local_configuration.api_token
      api_url = self.local_configuration.api_url
      autocomplete_key = self.local_configuration.autocomplete_key
      @http_client ||= Faraday.new(url: api_url)
      @http_client.basic_auth(api_token, '')

      send_request(path, method, @http_client, params, autocomplete_key, additional_query_params)
    end

    def send_request(path, method, http_client, params, autocomplete_key, additional_query_params)
      query_params = additional_query_params ? "&#{URI.encode_www_form(additional_query_params)}" : ""
      response = http_client.send(method) do |request|
        request.url "/v1/#{path}?autocomplete_key=#{autocomplete_key}#{query_params}"
        request.headers['Content-Type'] = 'application/json'
        request.body = params.to_json
      end
      response
    end
  end
end
