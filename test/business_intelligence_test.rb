require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/merchant_parser'
require_relative '../lib/invoice'
require_relative '../lib/invoice_repository'
require_relative '../lib/sales_engine'
require_relative '../lib/business_intelligence'
require_relative '../lib/higher_business_intelligence'

class MerchantIntelligenceTest < MiniTest::Test
  attr_reader :merchant_repo

  def setup
    sales_engine_test = SalesEngine.new
    @merchant_repo = sales_engine_test.merchant_repository
  end

  def test_finds_invoice_by_merchant_id
    result = @merchant_repo.find_invoice_by_merchant_id(11)
    assert_equal 54, result.id
    assert_equal 11, result.merchant_id
    assert_equal 12, result.customer_id
  end

  def test_finds_invoices_by_merchant_id
    result = @merchant_repo.find_invoices_by_merchant_id(11)

    assert result.is_a?(Array)
    assert result.first.is_a?(Invoice)
    assert_equal 54, result.first.id
    assert_equal 11, result.first.merchant_id
    assert_equal 12, result.first.customer_id
  end

  def test_it_finds_a_transaction_by_merchant_id
    result = @merchant_repo.find_transaction_by_merchant_id(11)

    assert_equal 62, result.id
    assert_equal 54, result.invoice_id
  end

  def test_it_finds_transactions_by_merchant_id
    result = @merchant_repo.find_transactions_by_merchant_id(22)

    assert result.is_a?(Array)
    assert result.first.is_a?(Transaction)
  end

  def test_it_finds_customer_by_merchant_id
    result = @merchant_repo.find_customer_by_merchant_id(13)

    assert_equal 64, result.id
    assert_equal "Isaac", result.first_name
    assert_equal "Zulauf", result.last_name
  end

  def test_it_finds_customers_by_merchant_id
    result = @merchant_repo.find_customers_by_merchant_id(@merchant_repo.random)

    assert result.is_a?(Array)
    assert result.first.is_a?(Customer)
  end

  def test_it_finds_good_transactions
    transactions = @merchant_repo.find_transactions_by_merchant_id(10)
    outcome = @merchant_repo.find_good_transactions(transactions)

    assert_equal "success", outcome.first.result
  end

  def test_it_finds_invoices_of_good_transactions
    transactions = @merchant_repo.find_transactions_by_merchant_id(10)
    result = @merchant_repo.find_good_transactions(transactions)
    outcome = @merchant_repo.find_invoices_of_transactions(result)

    assert outcome.is_a?(Array)
    assert outcome.first.is_a?(Invoice)
  end

  def test_it_groups_customers_by_invoices
    transactions = @merchant_repo.find_transactions_by_merchant_id(10)
    result = @merchant_repo.find_good_transactions(transactions)
    outcome = @merchant_repo.find_invoices_of_transactions(result)

    hashed_result = @merchant_repo.group_customers_and_invoices(outcome)


    assert hashed_result.is_a?(Hash)
    assert hashed_result.keys.first.is_a?(Integer)
    assert hashed_result.values.flatten.first.is_a?(Invoice)
  end



  def test_it_finds_the_favorite_customers_invoices
    transactions = @merchant_repo.find_transactions_by_merchant_id(10)
    result = @merchant_repo.find_good_transactions(transactions)
    outcome = @merchant_repo.find_invoices_of_transactions(result)
    hashed_result = @merchant_repo.group_customers_and_invoices(outcome)
    best_invoices = @merchant_repo.find_most_invoices(hashed_result)

    assert best_invoices.is_a?(Array)
    # binding.pry
    assert best_invoices.flatten.pop.is_a?(Invoice)
  end

  def test_it_finds_favorite_customer
    transactions = @merchant_repo.find_transactions_by_merchant_id(10)
    successful_transactions = @merchant_repo.find_good_transactions(transactions)
    invoices_of_transactions = @merchant_repo.find_invoices_of_transactions(successful_transactions)
    hashed_result = @merchant_repo.group_customers_and_invoices(invoices_of_transactions)
    best_invoices = @merchant_repo.find_most_invoices(hashed_result)
    final_result = @merchant_repo.find_favorite_customer(best_invoices)

    assert_equal "Lon", final_result.first_name

  end

  def test_it_gathers_invoice_items_related_to_transactions_for_revenue
    transactions = @merchant_repo.find_transactions_by_merchant_id(20)
    successful_transactions = @merchant_repo.find_good_transactions(transactions)
    invoice_ids = @merchant_repo.find_invoices_of_transactions(successful_transactions)
    invoice_items = @merchant_repo.find_invoice_items_by_invoice_ids(invoice_ids)

    assert invoice_items.first.is_a?(InvoiceItem)
  end

  def test_it_reduces_unit_price_and_revenue_into_a_large_int
    transactions = @merchant_repo.find_transactions_by_merchant_id(20)
    successful_transactions = @merchant_repo.find_good_transactions(transactions)
    invoice_ids = @merchant_repo.find_invoices_of_transactions(successful_transactions)
    invoice_items = @merchant_repo.find_invoice_items_by_invoice_ids(invoice_ids)
    revenue = @merchant_repo.reduce_invoice_items_revenues(invoice_items)

    assert revenue.is_a?(BigDecimal)
  end
end

class MerchantIntelligenceIntegrationTest < Minitest::Test

  def test_it_can_find_favorite_customer
    sales_engine = SalesEngine.new
    merchant_repo = sales_engine.merchant_repository
    merchant = merchant_repo.find_by_id(10)
    fav_customer = sales_engine.favorite_customer(merchant)

    assert_equal "Lon", fav_customer.first_name
    assert_equal "Harvey", fav_customer.last_name
  end

  def test_it_returns_revenue
    sales_engine = SalesEngine.new
    merchant_repo = sales_engine.merchant_repository
    merchant = merchant_repo.find_by_id(20)
    revenue = merchant.revenue

    assert_equal "454985.34", revenue.to_digits
    assert revenue.is_a?(BigDecimal)
  end


end

class InvoiceIntelligenceTest < Minitest::Test
  def setup
    sales_engine_test = SalesEngine.new
    @invoice_repo = sales_engine_test.invoice_repository
  end

  def test_it_collects_customers_with_good_transactions
    skip
    #didn't get to this business intelligence
    @invoice_repo.find_transactions_with_customer(12)
    result = @invoice_repo.find_customers_with_good_transactions(12)

  end
end
