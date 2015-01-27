require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_item'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/invoice_item'
require_relative '../lib/invoice_item_parser'
require_relative '../lib/item'

class InvoiceItemTest < MiniTest::Test

  def test_it_stores_an_id
    invoice_item = InvoiceItem.new({:id => 8}, nil)
    assert_equal 8, invoice_item.id
  end

  def test_it_stores_an_id_as_int_only
    invoice_item = InvoiceItem.new({:id => '7'}, nil)
    assert_equal 7, invoice_item.id
  end

  def test_it_stores_an_item_id_as_int_only
    invoice_item = InvoiceItem.new({:item_id => '45'}, nil)
    assert_equal 45, invoice_item.item_id
  end

  def test_it_stores_an_invoice_id_as_int
    invoice_item = InvoiceItem.new({:invoice_id => '21'}, nil)
    assert_equal 21, invoice_item.invoice_id
  end

end

class InvoiceItemRepositoryTest < MiniTest::Test

  def test_finds_nearest_by_invoice_id
    @invoice_item_repo = InvoiceItemRepository.new("test/support/invoice_items_sample.csv")
    @invoice_item_repo.collect_invoice_items
    invoice_item = @invoice_item_repo.find_by_invoice_id(2)
    assert_equal 2, invoice_item.invoice_id
  end

  def test_finds_nearest_by_item_id
    @invoice_item_repo = InvoiceItemRepository.new("test/support/invoice_items_sample.csv")
    @invoice_item_repo.collect_invoice_items
    invoice_item = @invoice_item_repo.find_by_item_id(535)
    assert_equal 1, invoice_item.invoice_id
    assert_equal 535, invoice_item.item_id
    assert_equal 4, invoice_item.id
  end

  def test_finds_nearest_by_quantity
    @invoice_item_repo = InvoiceItemRepository.new("test/support/invoice_items_sample.csv")
    @invoice_item_repo.collect_invoice_items
    invoice_item = @invoice_item_repo.find_by_quantity(4)
    assert_equal 7, invoice_item.id
    assert_equal 1, invoice_item.invoice_id
    assert_equal 530, invoice_item.item_id
    assert_equal 4, invoice_item.quantity
  end

  def test_finds_nearest_by_unit_price
    @invoice_item_repo = InvoiceItemRepository.new("test/support/invoice_items_sample.csv")
    @invoice_item_repo.collect_invoice_items
    invoice_item = @invoice_item_repo.find_by_unit_price(34873)
    assert_equal 1, invoice_item.invoice_id
    assert_equal 3, invoice_item.id
    assert_equal 8, invoice_item.quantity
    assert_equal 34873, invoice_item.unit_price
  end

  def test_finds_all_by_unit_price
    @invoice_item_repo = InvoiceItemRepository.new("test/support/invoice_items_sample.csv")
    @invoice_item_repo.collect_invoice_items
    invoice_item = @invoice_item_repo.find_all_by_unit_price(52100)
    assert_equal 6, invoice_item.first.id
    assert_equal 1, invoice_item.first.invoice_id
    assert_equal 541, invoice_item.first.item_id
    assert_equal 52100, invoice_item.first.unit_price
    assert_equal 5, invoice_item.first.quantity

    assert_equal 9, invoice_item[-1].id
    assert_equal 2, invoice_item[-1].invoice_id
    assert_equal 1832, invoice_item[-1].item_id
    assert_equal 52100, invoice_item[-1].unit_price
    assert_equal 6, invoice_item[-1].quantity
  end

  def test_finds_all_by_quantity
    @invoice_item_repo = InvoiceItemRepository.new("test/support/invoice_items_sample.csv")
    @invoice_item_repo.collect_invoice_items
    invoice_item = @invoice_item_repo.find_all_by_quantity(6)
    assert_equal 8, invoice_item.first.id
    assert_equal 1, invoice_item.first.invoice_id
    assert_equal 534, invoice_item.first.item_id
    assert_equal 76941, invoice_item.first.unit_price
    assert_equal 6, invoice_item.first.quantity

    assert_equal 9, invoice_item[-1].id
    assert_equal 2, invoice_item[-1].invoice_id
    assert_equal 1832, invoice_item[-1].item_id
    assert_equal 52100, invoice_item[-1].unit_price
    assert_equal 6, invoice_item[-1].quantity
  end

  def test_finds_all_by_invoice_id
    @invoice_item_repo = InvoiceItemRepository.new("test/support/invoice_items_sample.csv")
    @invoice_item_repo.collect_invoice_items
    invoice_item = @invoice_item_repo.find_all_by_invoice_id(2)
    assert_equal 1, invoice_item.first.id
    assert_equal 2, invoice_item.first.invoice_id
    assert_equal 13635, invoice_item.first.unit_price
    assert_equal 539, invoice_item.first.item_id
    assert_equal 5, invoice_item.first.quantity

    assert_equal 9, invoice_item[-1].id
    assert_equal 2, invoice_item[-1].invoice_id
    assert_equal 52100, invoice_item[-1].unit_price
    assert_equal 1832, invoice_item[-1].item_id
    assert_equal 6, invoice_item[-1].quantity
  end

end

class FakeInvoiceItemRepository
  attr_accessor :invoices, :items

  def find_invoice_by_invoice_id(invoice_id)
    @invoices
  end

  def find_items_by_item_id(item_id)
    @items
  end

end

class InvoiceItemIntegrationTest < MiniTest::Test
  def test_it_finds_related_invoice
    @invoice_item_repo = FakeInvoiceItemRepository.new
    data = {:id => "7"}
    @invoice_item = InvoiceItem.new(data, @invoice_item_repo)

    invoices = Array.new(5){ InvoiceItem.new(data, @invoice_item_repo) }
    @invoice_item_repo.invoices = invoices
    assert_equal invoices, @invoice_item.invoice
  end

  def test_it_finds_related_item_number
    @invoice_item_repo = FakeInvoiceItemRepository.new
    data = {:item_number => 529}
    @invoice_item = InvoiceItem.new(data, @invoice_item_repo)

    items = Array.new(5){ Item.new(data,@invoice_item_repo)}
    @invoice_item_repo.items = items
    assert_equal items, @invoice_item.item
  end

  def test_it_parses_a_file_and_returns_an_array_of_instances_which_know_the_repo
    @invoice_item_repo = InvoiceItemRepository.new("test/support/invoice_items_sample.csv")
    invoice_items = @invoice_item_repo.collect_invoice_items
    assert invoice_items.first.is_a?(InvoiceItem)
    assert_equal @invoice_item_repo, invoice_items.first.parent
  end

end

class InvoiceItemParserTest < MiniTest::Test
  def test_it_parses_a_csv_of_data
    filename = "test/support/invoice_items_sample.csv"
    parsed_invoice_items = InvoiceItemParser.parse(filename)

    first = parsed_invoice_items.first
    assert_equal 1, first.id
    assert_equal 539, first.item_id
    assert_equal 2, first.invoice_id

    fourth = parsed_invoice_items[3]
    assert_equal 4, fourth.id
    assert_equal 535, fourth.item_id
    assert_equal 1, fourth.invoice_id
  end

  def test_it_parses_unit_price
    filename = "test/support/invoice_items_sample.csv"
    parsed_invoice_items = InvoiceItemParser.parse(filename)

    third = parsed_invoice_items[2]
    assert_equal 34873, third.unit_price
    assert_equal 8, third.quantity

    fifth = parsed_invoice_items[4]
    assert_equal 79140, fifth.unit_price
    assert_equal 7, fifth.quantity
  end




end
