require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item'
require_relative '../lib/invoice'
# require_relative '../lib/invoice_item'
require_relative '../lib/item_parser'

class ItemTest < MiniTest::Test
#
#   def test_it_stores_an_id
#     item = Item.new({:id => 8}, nil)
#     assert_equal 8, item.id
#   end
#
#   def test_it_stores_an_id_as_int_only
#     item = Item.new({:id => '7'}, nil)
#     assert_equal 7, item.id
#   end
#
#   def test_it_stores_an_invoice_id_as_int_only
#     item = Item.new({:invoice_id => '45'}, nil)
#     assert_equal 45, item.invoice_id
#   end
end

class FakeItemRepository
#   attr_accessor :invoices
#
#   def find_invoices_by_invoice_id(invoice_id)
#     @invoices
#   end
#
end

class ItemIntegrationTest < MiniTest::Test
  def test_it_finds_related_invoice
    skip
    @item_repo = FakeItemRepository.new
    data = {:id => "7"}
    @item = Item.new(data, @item_repo)

    invoices = Array.new(5){ Invoice.new }
    @item_repo.invoices = invoices
    assert_equal invoices, @item.invoices
  end

  # def test_it_finds_related_credit_card_information
  #   @item_repo = FakeItemRepository.new
  #   data = {:credit_card_number => 2155676888724409}
  #   @item = Item.new(data, @item_repo)
  #
  #   assert_equal card_info, @item.credit_card_number
  # end

end

class ItemParserTest < MiniTest::Test
#   def test_it_parses_a_csv_of_data
#     filename = "test/support/item_sample.csv"
#     parser = ItemParser.new(filename)
#     items = parser.parse
#
#     first = items.first
#     assert_equal 1, first.id
#     assert_equal 1, first.invoice_id
#
#     fourth = items[3]
#     assert_equal 4, fourth.id
#     assert_equal 5, fourth.invoice_id
#   end
#
#   def test_it_parses_credit_card_data
#     filename = "test/support/item_sample.csv"
#     parser = ItemParser.new(filename)
#     items = parser.parse
#
#     third = items[2]
#     assert_equal 4354495077693036, third.credit_card_number
#     assert_equal "success", third.authorization_result
#
#     fifth = items[4]
#     assert_equal 4844518708741275, fifth.credit_card_number
#     assert_equal "failed", fifth.authorization_result
#   end
end
