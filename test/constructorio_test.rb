require_relative 'test_helper'

class ConstructorIOTest < MiniTest::Test
  def test_add_record_calls_post
    c = ConstructorIO::Client.new
    c.expects(:call_api).with(
      "item",
      "post",
      { item_name: "power drill" }
    )

    c.add( { item_name: "power drill" } )
  end

  def test_add_record_sends_request
    c = ConstructorIO::Client.new
    c.expects(:send_request).with(
      "item",
      "post",
      instance_of(Faraday::Connection),
      { item_name: "power drill" },
      "example_autocomplete_key",
      {}
    )

    c.add( { item_name: "power drill" } )
  end

  def test_add_or_update_record_calls_post
    c = ConstructorIO::Client.new
    c.expects(:call_api).with(
      "item",
      "put",
      { item_name: "power drill" },
      { force: 1 }
    )

    c.add_or_update( { item_name: "power drill" } )
  end

  def test_add_or_update_record_sends_request
    c = ConstructorIO::Client.new
    c.expects(:send_request).with(
      "item",
      "put",
      instance_of(Faraday::Connection),
      { item_name: "power drill" },
      "example_autocomplete_key",
      { force: 1 }
    )

    c.add_or_update( { item_name: "power drill" } )
  end

  def test_add_record_sends_request_with_local_config
    c = ConstructorIO::Client.new(ConstructorIO::Configuration.new(
      api_token: "this-api-token",
      autocomplete_key: "this-autocomplete-key",
      api_url: "https://devac.cnstrc.com")
    )
    c.expects(:send_request).with(
      "item",
      "post",
      instance_of(Faraday::Connection),
      { item_name: "power drill" },
      "this-autocomplete-key",
      {}
    )

    c.add( { item_name: "power drill" } )
  end

  def test_remove_record_calls_delete
    c = ConstructorIO::Client.new
    c.expects(:call_api).with(
      "item",
      "delete",
      { item_name: "power drill" }
    )

    c.remove( { item_name: "power drill" } )
  end

  def test_modify_record_calls_put
    c = ConstructorIO::Client.new
    c.expects(:call_api).with(
      "item",
      "put",
      { item_name: "power drill" }
    )

    c.modify( { item_name: "power drill" } )
  end

  def test_verify_calls_get
    c = ConstructorIO::Client.new
    c.expects(:call_api).with(
      "verify",
      "get"
    )

    c.verify
  end

  def test_verify_sends_request
    c = ConstructorIO::Client.new

    c.expects(:send_request).with(
      "verify",
      "get",
      instance_of(Faraday::Connection),
      {},
      "example_autocomplete_key",
      {}
    )

    c.verify
  end

  def test_add_batch_calls_post
    c = ConstructorIO::Client.new
    c.expects(:call_api).with(
      "batch_items",
      "post",
      { autocomplete_section: "Products", items: [ { item_name: "item" } ] }
    )

    c.add_batch(
      {
        autocomplete_section: "Products",
        items: [ { item_name: "item" } ] 
      }
    )
  end

  def test_add_batch_sends_request
    c = ConstructorIO::Client.new
    c.expects(:send_request).with(
      "batch_items",
      "post",
      instance_of(Faraday::Connection),
      { autocomplete_section: "Products", items: [ { item_name: "item" } ] },
      "example_autocomplete_key",
      {}
    )

    c.add_batch(
      {
        autocomplete_section: "Products",
        items: [ { item_name: "item" } ] 
      }
    )
  end

  def test_add_or_update_batch_calls_post
    c = ConstructorIO::Client.new
    c.expects(:call_api).with(
      "batch_items",
      "put",
      { autocomplete_section: "Products", items: [ { item_name: "item" } ] },
      { force: 1 }
    )

    c.add_or_update_batch(
      {
        autocomplete_section: "Products",
        items: [ { item_name: "item" } ] 
      }
    )
  end

  def test_add_or_update_batch_sends_request
    c = ConstructorIO::Client.new
    c.expects(:send_request).with(
      "batch_items",
      "put",
      instance_of(Faraday::Connection),
      { autocomplete_section: "Products", items: [ { item_name: "item" } ] },
      "example_autocomplete_key",
      { force: 1 }
    )

    c.add_or_update_batch(
      {
        autocomplete_section: "Products",
        items: [ { item_name: "item" } ] 
      }
    )
  end

  def test_remove_batch_sends_request
    c = ConstructorIO::Client.new
    c.expects(:send_request).with(
      "batch_items",
      "delete",
      instance_of(Faraday::Connection),
      { autocomplete_section: "Products", items: [ { item_name: "item" } ] },
      "example_autocomplete_key",
      {}
    )
    c.remove_batch(
      {
        autocomplete_section: "Products",
        items: [ { item_name: "item" } ]
      }
    )
  end
end
