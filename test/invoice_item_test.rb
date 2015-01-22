require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_item'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/invoice_item'
require_relative '../lib/invoice_item_parser'

class InvoiceItemTest < MiniTest::Test

  def test_it_stores_an_id
    invoice_item = InvoiceItem.new({:id => 8}, nil)
    assert_equal 8, invoice_item.id
  end

  def test_it_stores_an_id_as_int_only
    invoice_item = InvoiceItem.new({:id => '7'}, nil)
    assert_equal 7, invoice_item.id
  end

  def test_it_stores_an_invoice_id_as_int_only
    invoice_item = InvoiceItem.new({:invoice_id => '45'}, nil)
    assert_equal 45, invoice_item.invoice_id
  end
end

class InvoiceItemRepositoryTest < MiniTest::Test

  def test_finds_nearest_by_invoice_id
    @invoice_item_repo = InvoiceItemRepository.new("test/support/invoice_item_sample.csv")
    @invoice_item_repo.collect_invoice_items
    invoice_item = @invoice_item_repo.find_one_invoice_id(5)
    assert_equal 5, invoice_item.invoice_id
  end

  def test_finds_nearest_by_authorization
    @invoice_item_repo = InvoiceItemRepository.new("test/support/invoice_item_sample.csv")
    @invoice_item_repo.collect_invoice_items
    invoice_item = @invoice_item_repo.find_one_authorization("failed")
    assert_equal 6, invoice_item.invoice_id
    assert_equal "failed", invoice_item.authorization_result
  end

  def test_finds_nearest_by_credit_card_number
    @invoice_item_repo = InvoiceItemRepository.new("test/support/invoice_item_sample.csv")
    @invoice_item_repo.collect_invoice_items
    invoice_item = @invoice_item_repo.find_one_credit_card_number(4140149827486249)
    assert_equal 10, invoice_item.invoice_id
    assert_equal 9, invoice_item.id
    assert_equal 4140149827486249, invoice_item.credit_card_number
  end

  def test_finds_all_by_credit_card_number
    @invoice_item_repo = InvoiceItemRepository.new("test/support/invoice_item_sample.csv")
    @invoice_item_repo.collect_invoice_items
    invoice_item = @invoice_item_repo.find_all_by_credit_card_number(4844518708741275)
    assert_equal 6, invoice_item.first.invoice_id
    assert_equal 5, invoice_item.first.id
    assert_equal 4844518708741275, invoice_item.first.credit_card_number
    assert_equal "failed", invoice_item.first.authorization_result

    assert_equal 10, invoice_item[-1].invoice_id
    assert_equal 10, invoice_item[-1].id
    assert_equal 4844518708741275, invoice_item[-1].credit_card_number
    assert_equal "success", invoice_item[-1].authorization_result
  end

  def test_finds_all_by_authorization
    @invoice_item_repo = InvoiceItemRepository.new("test/support/invoice_item_sample.csv")
    @invoice_item_repo.collect_invoice_items
    invoice_item = @invoice_item_repo.find_all_by_authorization("failed")
    assert_equal 6, invoice_item.first.invoice_id
    assert_equal 5, invoice_item.first.id
    assert_equal 4844518708741275, invoice_item.first.credit_card_number
    assert_equal "failed", invoice_item.first.authorization_result

    assert_equal 9, invoice_item[-1].invoice_id
    assert_equal 8, invoice_item[-1].id
    assert_equal 4540842003561938, invoice_item[-1].credit_card_number
    assert_equal "failed", invoice_item[-1].authorization_result
  end

  def test_finds_all_by_invoice_id
    @invoice_item_repo = InvoiceItemRepository.new("test/support/invoice_item_sample.csv")
    @invoice_item_repo.collect_invoice_items
    invoice_item = @invoice_item_repo.find_all_by_invoice_id(10)
    assert_equal 10, invoice_item.first.invoice_id
    assert_equal 9, invoice_item.first.id
    assert_equal 4140149827486249, invoice_item.first.credit_card_number
    assert_equal "success", invoice_item.first.authorization_result

    assert_equal 10, invoice_item[-1].invoice_id
    assert_equal 10, invoice_item[-1].id
    assert_equal 4844518708741275, invoice_item[-1].credit_card_number
    assert_equal "success", invoice_item[-1].authorization_result
  end

end

class FakeInvoiceItemRepository
  attr_accessor :invoices

  def find_invoices_by_invoice_id(invoice_id)
    @invoices
  end

end

class InvoiceItemIntegrationTest < MiniTest::Test
  def test_it_finds_related_invoice
    @invoice_item_repo = FakeInvoiceItemRepository.new
    data = {:id => "7"}
    @invoice_item = InvoiceItem.new(data, @invoice_item_repo)

    invoices = Array.new(5){ Invoice.new }
    @invoice_item_repo.invoices = invoices
    assert_equal invoices, @invoice_item.invoices
  end

  def test_it_finds_related_credit_card_information
    @invoice_item_repo = FakeInvoiceItemRepository.new
    data = {:credit_card_number => 2155676888724409}
    @invoice_item = InvoiceItem.new(data, @invoice_item_repo)
    card_info = 2155676888724409
    assert_equal card_info, @invoice_item.credit_card_number
  end

  def test_it_parses_a_file_and_returns_an_array_of_instances_which_know_the_repo
    @invoice_item_repo = InvoiceItemRepository.new("test/support/invoice_item_sample.csv")
    invoice_item = @invoice_item_repo.collect_invoice_items
    assert invoice_item.first.is_a?(InvoiceItem)
  end

end

class InvoiceItemParserTest < MiniTest::Test
  def test_it_parses_a_csv_of_data
    filename = "test/support/invoice_item_sample.csv"
    parsed_invoice_items = InvoiceItemParser.parse(filename)

    first = parsed_invoice_items.first
    assert_equal 1, first.id
    assert_equal 1, first.invoice_id

    fourth = parsed_invoice_items[3]
    assert_equal 4, fourth.id
    assert_equal 5, fourth.invoice_id
  end

  def test_it_parses_credit_card_data
    filename = "test/support/invoice_item_sample.csv"
    parsed_invoice_items = InvoiceItemParser.parse(filename)

    third = parsed_invoice_items[2]
    assert_equal 4354495077693036, third.credit_card_number
    assert_equal "success", third.authorization_result

    fifth = parsed_invoice_items[4]
    assert_equal 4844518708741275, fifth.credit_card_number
    assert_equal "failed", fifth.authorization_result
  end




end
