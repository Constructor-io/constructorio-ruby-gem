require 'minitest/autorun'
require 'minitest/unit'
require 'mocha/mini_test'
require_relative '../lib/constructorio'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "test/fixtures/vcr_cassettes"
  config.hook_into :webmock
end

class ConstructorIOVCRTestErrors < MiniTest::Test
  def test_add_item_error
    ConstructorIO.configure do |config|
      config.api_token = "Bad token"
      config.autocomplete_key = ENV['CONSTRUCTORIO_AUTOCOMPLETE_KEY'] || "example_autocomplete_key"
      config.api_url = "http://dev.ac.cnstrc.com"
    end

    c = ConstructorIO::Client.new

    VCR.use_cassette("add_item_error") do
      response = c.add(
        { item_name: "power_drill", autocomplete_section: "standard" }
      )
      assert_equal 401, response.status
      assert_match /Invalid auth_token. If you've forgotten your token, you can generate a new one in the admin dashboard/, response.body
    end
  end
end
