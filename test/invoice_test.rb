require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice'
require_relative '../lib/invoice_parser'

class InvoiceTest < MiniTest::Test

  def test_it_stores_an_invoices_id_as_int_only
    invoice = Invoice.new({:invoices_id => 8}, nil)
    assert_equal 8, invoice.invoices_id
  end

  def test_it_stores_an_id_as_int_only
    invoice = Invoice.new({:id => '7'}, nil)
    assert_equal 7, invoice.id
  end

  def test_it_stores_an_invoice_id_as_int_only
  skip
    invoice = Invoice.new({:invoice_id => '45'}, nil)
    assert_equal 45, invoice.invoice_id
  end
end

class InvoiceRepositoryTest < MiniTest::Test

  def test_finds_nearest_by_invoice_id
  skip
    @invoice_repo = InvoiceRepository.new("test/support/invoice_sample.csv")
    @invoice_repo.collect_invoice
    invoice = @invoice_repo.find_one_invoice_id(5)
    assert_equal 5, invoice.invoice_id
  end

  def test_finds_nearest_by_authorization
  skip
    @invoice_repo = InvoiceRepository.new("test/support/invoice_sample.csv")
    @invoice_repo.collect_invoice
    invoice = @invoice_repo.find_one_authorization("failed")
    assert_equal 6, invoice.invoice_id
    assert_equal "failed", invoice.authorization_result
  end

  def test_finds_nearest_by_credit_card_number
  skip
    @invoice_repo = InvoiceRepository.new("test/support/invoice_sample.csv")
    @invoice_repo.collect_invoice
    invoice = @invoice_repo.find_one_credit_card_number(4140149827486249)
    assert_equal 10, invoice.invoice_id
    assert_equal 9, invoice.id
    assert_equal 4140149827486249, invoice.credit_card_number
  end

  def test_finds_all_by_credit_card_number
  skip
    @invoice_repo = InvoiceRepository.new("test/support/invoice_sample.csv")
    @invoice_repo.collect_invoice
    invoice = @invoice_repo.find_all_by_credit_card_number(4844518708741275)
    assert_equal 6, invoice.first.invoice_id
    assert_equal 5, invoice.first.id
    assert_equal 4844518708741275, invoice.first.credit_card_number
    assert_equal "failed", invoice.first.authorization_result

    assert_equal 10, invoice[-1].invoice_id
    assert_equal 10, invoice[-1].id
    assert_equal 4844518708741275, invoice[-1].credit_card_number
    assert_equal "success", invoice[-1].authorization_result
  end

  def test_finds_all_by_authorization
  skip
    @invoice_repo = InvoiceRepository.new("test/support/invoice_sample.csv")
    @invoice_repo.collect_invoice
    invoice = @invoice_repo.find_all_by_authorization("failed")
    assert_equal 6, invoice.first.invoice_id
    assert_equal 5, invoice.first.id
    assert_equal 4844518708741275, invoice.first.credit_card_number
    assert_equal "failed", invoice.first.authorization_result

    assert_equal 9, invoice[-1].invoice_id
    assert_equal 8, invoice[-1].id
    assert_equal 4540842003561938, invoice[-1].credit_card_number
    assert_equal "failed", invoice[-1].authorization_result
  end

  def test_finds_all_by_invoice_id
  skip
    @invoice_repo = InvoiceRepository.new("test/support/invoice_sample.csv")
    @invoice_repo.collect_invoice
    invoice = @invoice_repo.find_all_by_invoice_id(10)
    assert_equal 10, invoice.first.invoice_id
    assert_equal 9, invoice.first.id
    assert_equal 4140149827486249, invoice.first.credit_card_number
    assert_equal "success", invoice.first.authorization_result

    assert_equal 10, invoice[-1].invoice_id
    assert_equal 10, invoice[-1].id
    assert_equal 4844518708741275, invoice[-1].credit_card_number
    assert_equal "success", invoice[-1].authorization_result
  end

end

class FakeInvoiceRepository
  attr_accessor :invoices

  def find_invoices_by_invoice_id(invoice_id)
  skip
    @invoices
  end

end

class InvoiceIntegrationTest < MiniTest::Test
  def test_it_finds_related_invoice
  skip
    @invoice_repo = FakeInvoiceRepository.new
    data = {:id => "7"}
    @invoice = Invoice.new(data, @invoice_repo)

    invoices = Array.new(5){ Invoice.new }
    @invoice_repo.invoices = invoices
    assert_equal invoices, @invoice.invoices
  end

  def test_it_finds_related_credit_card_information
  skip
    @invoice_repo = FakeInvoiceRepository.new
    data = {:credit_card_number => 2155676888724409}
    @invoice = Invoice.new(data, @invoice_repo)
    card_info = 2155676888724409
    assert_equal card_info, @invoice.credit_card_number
  end

  def test_it_parses_a_file_and_returns_an_array_of_instances_which_know_the_repo
  skip
    @invoice_repo = InvoiceRepository.new("test/support/invoice_sample.csv")
    invoice = @invoice_repo.collect_invoice
    assert invoice.first.is_a?(Invoice)
  end

end

class InvoiceParserTest < MiniTest::Test
  def test_it_parses_a_csv_of_data
  skip
    filename = "test/support/invoice_sample.csv"
    parsed_invoices = InvoiceParser.parse(filename)

    first = parsed_invoices.first
    assert_equal 1, first.id
    assert_equal 1, first.invoice_id

    fourth = parsed_invoices[3]
    assert_equal 4, fourth.id
    assert_equal 5, fourth.invoice_id
  end

  def test_it_parses_credit_card_data
  skip
    filename = "test/support/invoice_sample.csv"
    parsed_invoices = InvoiceParser.parse(filename)

    third = parsed_invoices[2]
    assert_equal 4354495077693036, third.credit_card_number
    assert_equal "success", third.authorization_result

    fifth = parsed_invoices[4]
    assert_equal 4844518708741275, fifth.credit_card_number
    assert_equal "failed", fifth.authorization_result
  end




end
