require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice'
require_relative '../lib/customer'
require_relative '../lib/merchant'
require_relative '../lib/invoice_repository'
require_relative '../lib/transaction'
require_relative '../lib/invoice_parser'

class InvoiceTest < MiniTest::Test

  def test_it_stores_ids_as_int_only
    invoice = Invoice.new({:id => 8,
                           :customer_id => 2,
                           :merchant_id => 83},
                            nil)
    assert_equal 8, invoice.id
    assert_equal 2, invoice.customer_id
    assert_equal 83, invoice.merchant_id
  end

  def test_it_stores_status_as_a_string
    invoice = Invoice.new({:status => 'shipped'}, nil)
    assert_equal "shipped", invoice.status
  end
end

class InvoiceRepositoryTest < MiniTest::Test

  def test_finds_nearest_by_id
    @invoice_repo = InvoiceRepository.new("test/support/invoices_sample.csv")
    @invoice_repo.collect_invoices
    invoice = @invoice_repo.find_by_id(5)
    assert_equal 5, invoice.id
  end

  def test_finds_nearest_by_customer_id
    @invoice_repo = InvoiceRepository.new("test/support/invoices_sample.csv")
    @invoice_repo.collect_invoices
    invoice = @invoice_repo.find_by_customer_id(1)
    assert_equal 1, invoice.id
    assert_equal 1, invoice.customer_id
  end

  def test_finds_nearest_by_merchant_id
    @invoice_repo = InvoiceRepository.new("test/support/invoices_sample.csv")
    @invoice_repo.collect_invoices
    invoice = @invoice_repo.find_by_merchant_id(78)
    assert_equal 3, invoice.id
    assert_equal 1, invoice.customer_id
    assert_equal 78, invoice.merchant_id
  end

  def test_finds_nearest_by_status
    @invoice_repo = InvoiceRepository.new("test/support/invoices_sample.csv")
    @invoice_repo.collect_invoices
    invoice = @invoice_repo.find_by_status("shipped")
    assert_equal 1, invoice.id
    assert_equal 1, invoice.customer_id
    assert_equal 26, invoice.merchant_id
    assert_equal "shipped", invoice.status
  end


  def test_finds_nearest_by_created_at
    @invoice_repo = InvoiceRepository.new("test/support/invoices_sample.csv")
    @invoice_repo.collect_invoices
    invoice = @invoice_repo.find_by_created_at("2012-03-12 05:54:09 UTC")
    assert_equal 2, invoice.id
    assert_equal 1, invoice.customer_id
    assert_equal 75, invoice.merchant_id
    assert_equal "2012-03-12 05:54:09 UTC", invoice.created_at
  end

  def test_finds_nearest_by_updated_at
    @invoice_repo = InvoiceRepository.new("test/support/invoices_sample.csv")
    @invoice_repo.collect_invoices
    invoice = @invoice_repo.find_by_updated_at("2012-03-07 19:54:10 UTC")
    assert_equal 5, invoice.id
    assert_equal 1, invoice.customer_id
    assert_equal 44, invoice.merchant_id
    assert_equal "2012-03-07 19:54:10 UTC", invoice.updated_at
  end

  def test_finds_all_by_id
    @invoice_repo = InvoiceRepository.new("test/support/invoices_sample.csv")
    @invoice_repo.collect_invoices
    invoice = @invoice_repo.find_all_by_id(6)
    assert_equal 6, invoice.first.id
    assert_equal 1, invoice.first.customer_id
    assert_equal 76, invoice.first.merchant_id
    assert_equal "shipped", invoice.first.status

    assert_equal 6, invoice[-1].id
    assert_equal 1, invoice[-1].customer_id
    assert_equal 44, invoice[-1].merchant_id
    assert_equal "shipped", invoice[-1].status
  end

  def test_finds_all_by_customer_id
    @invoice_repo = InvoiceRepository.new("test/support/invoices_sample.csv")
    @invoice_repo.collect_invoices
    invoice = @invoice_repo.find_all_by_customer_id(2)
    assert_equal 8, invoice.first.id
    assert_equal 2, invoice.first.customer_id
    assert_equal 38, invoice.first.merchant_id
    assert_equal "shipped", invoice.first.status

    assert_equal 9, invoice[-1].id
    assert_equal 2, invoice[-1].customer_id
    assert_equal 27, invoice[-1].merchant_id
    assert_equal "pending", invoice[-1].status
  end

  def test_finds_all_by_merchant_id
    @invoice_repo = InvoiceRepository.new("test/support/invoices_sample.csv")
    @invoice_repo.collect_invoices
    invoice = @invoice_repo.find_all_by_merchant_id(44)
    assert_equal 5, invoice.first.id
    assert_equal 1, invoice.first.customer_id
    assert_equal 44, invoice.first.merchant_id
    assert_equal "pending", invoice.first.status

    assert_equal 6, invoice[-1].id
    assert_equal 1, invoice[-1].customer_id
    assert_equal 44, invoice[-1].merchant_id
    assert_equal "shipped", invoice[-1].status
  end

  def test_finds_all_by_created_at
    @invoice_repo = InvoiceRepository.new("test/support/invoices_sample.csv")
    @invoice_repo.collect_invoices
    invoice = @invoice_repo.find_all_by_created_at("2012-03-12 05:54:09 UTC")
    assert_equal 2, invoice.first.id
    assert_equal 1, invoice.first.customer_id
    assert_equal 75, invoice.first.merchant_id
    assert_equal "shipped", invoice.first.status
    assert_equal "2012-03-12 05:54:09 UTC", invoice.first.created_at

    assert_equal 3, invoice[-1].id
    assert_equal 1, invoice[-1].customer_id
    assert_equal 78, invoice[-1].merchant_id
    assert_equal "shipped", invoice[-1].status
    assert_equal "2012-03-12 05:54:09 UTC", invoice[-1].created_at
  end

  def test_finds_all_by_updated_at
    @invoice_repo = InvoiceRepository.new("test/support/invoices_sample.csv")
    @invoice_repo.collect_invoices
    invoice = @invoice_repo.find_all_by_updated_at("2012-03-07 12:54:10 UTC")
    assert_equal 6, invoice.first.id
    assert_equal 1, invoice.first.customer_id
    assert_equal 44, invoice.first.merchant_id
    assert_equal "shipped", invoice.first.status
    assert_equal "2012-03-07 12:54:10 UTC", invoice.first.updated_at

    assert_equal 9, invoice[-1].id
    assert_equal 2, invoice[-1].customer_id
    assert_equal 27, invoice[-1].merchant_id
    assert_equal "pending", invoice[-1].status
    assert_equal "2012-03-07 12:54:10 UTC", invoice[-1].updated_at
  end

end

class FakeInvoiceRepository
  attr_accessor :transactions,
                :customers,
                :merchants,
                :invoice_items

  def find_transactions_by_invoices_id(id)
    @transactions
  end

  def find_customers_by_customer_id(customer_id)
    @customers
  end

  def find_merchants_by_merchant_id(merchant_id)
    @merchants
  end

  def find_invoice_items_by_invoices_id(id)
    @invoice_items
  end
end

class InvoiceIntegrationTest < MiniTest::Test
  def test_it_finds_related_transaction
    @invoice_repo = FakeInvoiceRepository.new
    data = {:id => "7"}
    @invoice = Invoice.new(data, @invoice_repo)
    other_data = {:id => "7"}

    transactions = Array.new(5){ Transaction.new(other_data, nil) }
    @invoice_repo.transactions = transactions
    assert_equal transactions, @invoice.transaction
  end

  def test_it_finds_related_customer
    @invoice_repo = FakeInvoiceRepository.new
    data = {:customer_id => "2"}
    @invoice = Invoice.new(data, @invoice_repo)
    other_data = {:id => "2"}

    customers = Array.new(5){ Customer.new(other_data, nil) }
    @invoice_repo.customers = customers
    assert_equal customers, @invoice.customer
  end

  def test_it_finds_related_merchant
    @invoice_repo = FakeInvoiceRepository.new
    data = {:merchant_id => "7"}
    @invoice = Invoice.new(data, @invoice_repo)
    other_data = {:id => "66"}

    merchants = Array.new(5){ Merchant.new(other_data, nil) }
    @invoice_repo.merchants = merchants
    assert_equal merchants, @invoice.merchant
  end

  def test_it_finds_related_invoice_item
    @invoice_repo = FakeInvoiceRepository.new
    data = {:id => "3"}
    @invoice = Invoice.new(data, @invoice_repo)
    other_data = {:id => "3"}

    invoice_items = Array.new(5){ Transaction.new(other_data, nil) }
    @invoice_repo.invoice_items = invoice_items
    assert_equal invoice_items, @invoice.invoice_item
  end

  def test_it_parses_a_file_and_returns_an_array_of_instances_which_know_the_repo
    @invoice_repo = InvoiceRepository.new("test/support/invoices_sample.csv")
    invoices = @invoice_repo.collect_invoices
    assert invoices.first.is_a?(Invoice)
    assert_equal @invoice_repo, invoices.first.parent
  end

end

class InvoiceParserTest < MiniTest::Test
  def test_it_parses_a_csv_of_data
    filename = "test/support/invoices_sample.csv"
    parsed_invoices = InvoiceParser.parse(filename)

    first = parsed_invoices.first
    assert_equal 1, first.id
    assert_equal 26, first.merchant_id

    fourth = parsed_invoices[3]
    assert_equal 4, fourth.id
    assert_equal 33, fourth.merchant_id
  end

  def test_it_parses_credit_card_data
    filename = "test/support/invoices_sample.csv"
    parsed_invoices = InvoiceParser.parse(filename)

    third = parsed_invoices[2]
    assert_equal 1, third.customer_id
    assert_equal "shipped", third.status

    ninth = parsed_invoices[8]
    assert_equal 2, ninth.customer_id
    assert_equal "pending", ninth.status
  end
end
