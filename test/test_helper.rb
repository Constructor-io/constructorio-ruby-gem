require 'minitest/autorun'
require 'minitest/unit'
require 'mocha/mini_test'
require_relative '../lib/constructorio'

ConstructorIO.configure do |config|
  config.api_token = "example_api_token"
  config.autocomplete_key = "example_autocomplete_key"
  config.api_url = "http://example.constructor.io"
end
