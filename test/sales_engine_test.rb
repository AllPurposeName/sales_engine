require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def sales_engine
    sales_engine = SalesEngine.new
  end

  def test_response_to_startup
    assert sales_engine.respond_to?(:startup)
  end

  def test_a_sales_engine_has_a_customer_repository
    sales_engine.startup
    assert sales_engine.customer_repository
  end

  def test_a_sales_engine_has_a_invoice_item_repository
    sales_engine.startup
    assert sales_engine.invoice_item_repository
  end

  def test_a_sales_engine_has_an_invoice_repository
    sales_engine.startup
    assert sales_engine.invoice_repository
  end

  def test_a_sales_engine_has_an_item_repository
    sales_engine.startup
    assert sales_engine.item_repository
  end

  def test_a_sales_engine_has_a_merchant_repository
    sales_engine.startup
    assert sales_engine.merchant_repository
  end

  def test_a_sales_engine_has_a_transaction_repository
    sales_engine.startup
    assert sales_engine.transaction_repository
  end

end
