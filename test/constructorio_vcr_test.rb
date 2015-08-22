require_relative 'test_helper'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "test/fixtures/vcr_cassettes"
  config.hook_into :webmock
end

class ConstructorIOVCRTest < MiniTest::Test
  def test_add_item
    c = ConstructorIO::Client.new

    VCR.use_cassette("add_item") do
      response = c.add(
        { item_name: "power_drill", autocomplete_section: "standard" }
      )
      assert_equal response.status, 204
    end
  end

  def test_remove_item
    c = ConstructorIO::Client.new

    VCR.use_cassette("remove_item") do
      response = c.remove(
        { item_name: "power_drill", autocomplete_section: "standard" }
      )
      assert_equal response.status, 204
    end
  end

  def test_modify_item
    c = ConstructorIO::Client.new

    VCR.use_cassette("modify_item") do
      response = c.remove(
        { item_name: "power_drill", autocomplete_section: "standard", suggested_score: 10 }
      )
      assert_equal response.status, 204
    end
  end
end
