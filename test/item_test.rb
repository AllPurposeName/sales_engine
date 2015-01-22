require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item'
require_relative '../lib/item_repository'
require_relative '../lib/invoice'
require_relative '../lib/item_parser'

class ItemTest < MiniTest::Test

  def test_it_stores_an_id
    item = Item.new({:id => 8}, nil)
    assert_equal 8, item.id
  end

  def test_it_stores_an_id_as_int_only
    item = Item.new({:id => '7'}, nil)
    assert_equal 7, item.id
  end

  def test_it_stores_an_invoice_id_as_int_only
    item = Item.new({:invoice_id => '45'}, nil)
    assert_equal 45, item.invoice_id
  end
end

class ItemRepositoryTest < MiniTest::Test

  def test_finds_nearest_by_invoice_id
    @item_repo = ItemRepository.new("test/support/item_sample.csv")
    @item_repo.collect_items
    item = @item_repo.find_one_invoice_id(5)
    assert_equal 5, item.invoice_id
  end

  def test_finds_nearest_by_authorization
    @item_repo = ItemRepository.new("test/support/item_sample.csv")
    @item_repo.collect_items
    item = @item_repo.find_one_authorization("failed")
    assert_equal 6, item.invoice_id
    assert_equal "failed", item.authorization_result
  end

  def test_finds_nearest_by_credit_card_number
    @item_repo = ItemRepository.new("test/support/item_sample.csv")
    @item_repo.collect_items
    item = @item_repo.find_one_credit_card_number(4140149827486249)
    assert_equal 10, item.invoice_id
    assert_equal 9, item.id
    assert_equal 4140149827486249, item.credit_card_number
  end

  def test_finds_all_by_credit_card_number
    @item_repo = ItemRepository.new("test/support/item_sample.csv")
    @item_repo.collect_items
    items = @item_repo.find_all_by_credit_card_number(4844518708741275)
    assert_equal 6, items.first.invoice_id
    assert_equal 5, items.first.id
    assert_equal 4844518708741275, items.first.credit_card_number
    assert_equal "failed", items.first.authorization_result

    assert_equal 10, items[-1].invoice_id
    assert_equal 10, items[-1].id
    assert_equal 4844518708741275, items[-1].credit_card_number
    assert_equal "success", items[-1].authorization_result
  end

  def test_finds_all_by_authorization
    @item_repo = ItemRepository.new("test/support/item_sample.csv")
    @item_repo.collect_items
    items = @item_repo.find_all_by_authorization("failed")
    assert_equal 6, items.first.invoice_id
    assert_equal 5, items.first.id
    assert_equal 4844518708741275, items.first.credit_card_number
    assert_equal "failed", items.first.authorization_result

    assert_equal 9, items[-1].invoice_id
    assert_equal 8, items[-1].id
    assert_equal 4540842003561938, items[-1].credit_card_number
    assert_equal "failed", items[-1].authorization_result
  end

  def test_finds_all_by_invoice_id
    @item_repo = ItemRepository.new("test/support/item_sample.csv")
    @item_repo.collect_items
    items = @item_repo.find_all_by_invoice_id(10)
    assert_equal 10, items.first.invoice_id
    assert_equal 9, items.first.id
    assert_equal 4140149827486249, items.first.credit_card_number
    assert_equal "success", items.first.authorization_result

    assert_equal 10, items[-1].invoice_id
    assert_equal 10, items[-1].id
    assert_equal 4844518708741275, items[-1].credit_card_number
    assert_equal "success", items[-1].authorization_result
  end

end

class FakeItemRepository
  attr_accessor :invoices

  def find_invoices_by_invoice_id(invoice_id)
    @invoices
  end

end

class ItemIntegrationTest < MiniTest::Test
  def test_it_finds_related_invoice
    @item_repo = FakeItemRepository.new
    data = {:id => "7"}
    @item = Item.new(data, @item_repo)

    invoices = Array.new(5){ Invoice.new }
    @item_repo.invoices = invoices
    assert_equal invoices, @item.invoices
  end

  def test_it_finds_related_credit_card_information
    @item_repo = FakeItemRepository.new
    data = {:credit_card_number => 2155676888724409}
    @item = Item.new(data, @item_repo)
    card_info = 2155676888724409
    assert_equal card_info, @item.credit_card_number
  end

  def test_it_parses_a_file_and_returns_an_array_of_instances_which_know_the_repo
    @item_repo = ItemRepository.new("test/support/item_sample.csv")
    items = @item_repo.collect_items
    assert items.first.is_a?(Item)
  end

end

class ItemParserTest < MiniTest::Test
  def test_it_parses_a_csv_of_data
    filename = "test/support/item_sample.csv"
    parsed_items = ItemParser.parse(filename)

    first = parsed_items.first
    assert_equal 1, first.id
    assert_equal 1, first.invoice_id

    fourth = parsed_items[3]
    assert_equal 4, fourth.id
    assert_equal 5, fourth.invoice_id
  end

  def test_it_parses_credit_card_data
    filename = "test/support/item_sample.csv"
    parsed_items = ItemParser.parse(filename)

    third = parsed_items[2]
    assert_equal 4354495077693036, third.credit_card_number
    assert_equal "success", third.authorization_result

    fifth = parsed_items[4]
    assert_equal 4844518708741275, fifth.credit_card_number
    assert_equal "failed", fifth.authorization_result
  end




end
