require_relative 'test_helper'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "test/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.default_cassette_options = { :record => :none }
end

class ConstructorIOVCRTest < MiniTest::Test
  def test_add_item
    c = ConstructorIO::Client.new

    VCR.use_cassette("add_item") do
      response = c.add(
        { item_name: "power_drill", autocomplete_section: "Search Suggestions" }
      )
      assert_equal response.status, 204
    end
  end

  def test_add_item_with_metadata
    c = ConstructorIO::Client.new

    VCR.use_cassette("add_item_with_metadata") do
      response = c.add(
        { item_name: "power_drill", autocomplete_section: "Products", url: "/condition/1", metadata: { key1: "value1", key2: "value2" } }
      )
      assert_equal response.status, 204
    end
  end

  def test_add_or_update_item
    c = ConstructorIO::Client.new

    VCR.use_cassette("add_or_update_item") do
      response = c.add_or_update(
        { item_name: "power_drill", autocomplete_section: "Search Suggestions" }
      )
      assert_equal response.status, 204
    end
  end

  def test_add_batch
    c = ConstructorIO::Client.new

    VCR.use_cassette("add_batch") do
      response = c.add_batch(
        autocomplete_section: "Search Suggestions",
        items: [
          { item_name: "power drill x11" },
          { item_name: "power drill x12" },
          { item_name: "power drill x13" },
          { item_name: "power drill x14" },
        ]
      )
      assert_equal response.status, 204
    end
  end

  def test_add_batch_with_metadata
    c = ConstructorIO::Client.new

    VCR.use_cassette("add_batch_with_metadata") do
      response = c.add_batch(
        autocomplete_section: "Products",
        items: [
          { item_name: "power_drill 1", url: "/condition/1", metadata: { key1: "value1", key2: "value2" } },
          { item_name: "power_drill 2", url: "/condition/2", metadata: { key3: "value3", key4: "value4" } },
          { item_name: "power_drill 3", url: "/condition/3", metadata: { key5: "value5", key6: "value6" } }
        ]
      )
      assert_equal response.status, 204
    end
  end

  def test_add_or_update_batch
    c = ConstructorIO::Client.new

    VCR.use_cassette("add_or_update_batch") do
      response = c.add_or_update_batch(
        autocomplete_section: "Search Suggestions",
        items: [
          { item_name: "power drill x1" },
          { item_name: "power drill x2" },
          { item_name: "power drill x3" },
          { item_name: "power drill x4" },
        ]
      )
      assert_equal response.status, 204
    end
  end

  def test_remove_item
    c = ConstructorIO::Client.new

    VCR.use_cassette("remove_item") do
      response = c.remove(
        { item_name: "power_drill", autocomplete_section: "Search Suggestions" }
      )
      assert_equal response.status, 204
    end
  end

  def test_remove_batch
    c = ConstructorIO::Client.new

    VCR.use_cassette("remove_batch") do
      response = c.remove_batch(
        autocomplete_section: "Search Suggestions",
        items: [
          { item_name: "power_drill x1" },
          { item_name: "power_drill x2" },
          { item_name: "power_drill x3" },
          { item_name: "power_drill x4" },
        ]
      )
      assert_equal response.status, 204
    end
  end

  def test_modify_item
    c = ConstructorIO::Client.new

    VCR.use_cassette("modify_item") do
      response = c.remove(
        { item_name: "power_drill", autocomplete_section: "Search Suggestions", suggested_score: 10 }
      )
      assert_equal response.status, 204
    end
  end
end
