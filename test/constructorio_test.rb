require_relative 'test_helper'

class ConstructorIOTest < MiniTest::Test
  def test_add_record_calls_post
    c = ConstructorIO::Client.new
    c.expects(:call_api).with(
      "post", { item_name: "power drill" })

    c.add( { item_name: "power drill" } )
  end

  def test_add_record_sends_request
    c = ConstructorIO::Client.new
    c.expects(:send_request).with(
      "post",
      instance_of(Faraday::Connection),
      { item_name: "power drill" },
      "example_autocomplete_key"
    )

    c.add( { item_name: "power drill" } )
  end

  def test_remove_record_calls_delete
    c = ConstructorIO::Client.new
    c.expects(:call_api).with(
      "delete", { item_name: "power drill" })

    c.remove( { item_name: "power drill" } )
  end

  def test_modify_record_calls_put
    c = ConstructorIO::Client.new
    c.expects(:call_api).with(
      "put", { item_name: "power drill" })

    c.modify( { item_name: "power drill" } )
  end

end
