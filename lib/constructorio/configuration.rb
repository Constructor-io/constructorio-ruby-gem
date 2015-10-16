module ConstructorIO
  class Configuration
    attr_accessor :api_token, :autocomplete_key, :api_url

    def initialize(opts = {})
      self.api_token = opts[:api_token]
      self.api_url = opts[:api_url]
      self.autocomplete_key = opts[:autocomplete_key]
    end
  end

end
