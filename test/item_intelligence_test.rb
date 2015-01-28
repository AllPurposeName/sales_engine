require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item'
require_relative '../lib/item_repository'
require_relative '../lib/item'
require_relative '../lib/item_parser'

class FakeSalesEngine
  def invoice_repository
    invoice_for_test = Invoice.new({ :merchant_id => 7 }, self)
  end
end

class ItemIntelligenceTest < MiniTest::Test

  def test_a_sales_engine_has_an_invoice_item_repository
    sales_engine.startup
    assert sales_engine.invoice_item_repository
  end

  def test_a_sales_engine_has_a_item_repository
    sales_engine.startup
    assert sales_engine.item_repository
  end

  def test_it_finds_item_from_item_id
    assert sales_engine.respond_to?(:find_item_from)
  end

  def test_it_finds_invoice_items_from_item_id
    assert sales_engine.respond_to?(:find_invoice_items_from)
  end

  def test_it_finds_highest_revenue_items
    assert sales_engine.respond_to?(:find_most_revenue_items)
  end
end

class ItemIntelligenceTest < MiniTest::Test
