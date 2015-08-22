require 'minitest/autorun'
require 'minitest/unit'
require 'mocha/mini_test'
require_relative '../lib/constructorio'

ConstructorIO.configure do |config|
  config.api_token = ENV['CONSTRUCTORIO_API_TOKEN'] || "example_api_token"
  config.autocomplete_key = ENV['CONSTRUCTORIO_AUTOCOMPLETE_KEY'] || "example_autocomplete_key"
  config.api_url = "http://dev.ac.cnstrc.com"
end
