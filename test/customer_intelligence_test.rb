require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/customer'
require_relative '../lib/customer_repository'
require_relative '../lib/customer'
require_relative '../lib/customer_parser'
require_relative '../lib/sales_engine'

class CustomerIntelligenceTest < MiniTest::Test

  def test_it_finds_invoices_from_customer_id
    assert sales_engine.respond_to?(:find_invoices_from_customer)
  end

  def test_it_finds_transactions_from_customer_id
    assert sales_engine.respond_to?(:find_transactions_from_customer)
    #sales_engine.find_transactions_from_customer("1")
  end

  def test_it_finds_favorite_merchant_from_customer_id
    sales_engine.find_favorite_merchant_from_customer("1")
    assert sales_engine.respond_to?(:find_favorite_merchant_from_customer)
  end

  def test_it_finds_customer_from_customer_id
    assert sales_engine.respond_to?(:find_customer_from)
  end
end

class CustomerIntegrationTest < MiniTest::Test
