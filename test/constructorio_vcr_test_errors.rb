require 'minitest/autorun'
require 'minitest/unit'
require 'mocha/mini_test'
require_relative '../lib/constructorio'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "test/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.default_cassette_options = { :record => :none }
end

class ConstructorIOVCRTestErrors < MiniTest::Test
  def test_add_item_bad_token_error
    c = ConstructorIO::Client.new(ConstructorIO::Configuration.new(
      api_token: "Bad token",
      autocomplete_key: ENV['CONSTRUCTORIO_AUTOCOMPLETE_KEY'] || "example_autocomplete_key",
      api_url: "https://devac.cnstrc.com")
    )

    VCR.use_cassette("add_item_error") do
      response = c.add(
        { item_name: "power_drill", autocomplete_section: "standard" }
      )
      assert_equal 401, response.status
      assert_match(/Invalid auth_token. If you've forgotten your token, you can generate a new one in the admin dashboard/, response.body)
    end
  end

  def test_add_item_bad_key_error
    c = ConstructorIO::Client.new(ConstructorIO::Configuration.new(
      api_token: ENV['CONSTRUCTORIO_API_TOKEN'] || "example_api_token",
      autocomplete_key: "bad_autocomplete_key",
      api_url: "https://devac.cnstrc.com")
    )

    VCR.use_cassette("add_item_error") do
      response = c.add(
        { item_name: "power_drill", autocomplete_section: "standard" }
      )
      assert_equal 401, response.status
      assert_match(/You have supplied an invalid autocomplete key. Look up your valid autocomplete key in your admin dashboard/, response.body)
    end
  end
end
