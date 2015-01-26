require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item'
require_relative '../lib/item_repository'
# require_relative '../lib/invoice'
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

  def test_it_stores_a_name
    item = Item.new({:name => 'Manny'}, nil)
    assert_equal 'Manny', item.name
  end

  def test_it_stores_a_description
    item = Item.new({:description => 'Nihil autem sit odio inventore deleniti.'}, nil)
    assert_equal 'Nihil autem sit odio inventore deleniti.', item.description
  end

  def test_it_stores_a_unit_price
    item = Item.new({:unit_price => 75107}, nil)
    assert_equal 75107, item.unit_price
  end
end

class ItemRepositoryTest < MiniTest::Test

  def test_finds_nearest_by_item_id
    @item_repo = ItemRepository.new("test/support/items_sample.csv")
    @item_repo.collect_items
    item = @item_repo.find_one_item_id(5)
    assert_equal 5, item.id
  end

  def test_finds_nearest_by_name
    @item_repo = ItemRepository.new("test/support/items_sample.csv")
    @item_repo.collect_items
    item = @item_repo.find_one_by_name("Item Provident At")
    assert_equal 6, item.id
    assert_equal "Item Provident At", item.name
  end

  def test_finds_nearest_by_description
    @item_repo = ItemRepository.new("test/support/items_sample.csv")
    @item_repo.collect_items
    item = @item_repo.find_one_by_description('Sunt eum id eius magni consequuntur delectus veritatis. Quisquam laborum illo ut ab. Ducimus in est id voluptas autem.')
    assert_equal 4, item.id
    assert_equal 'Sunt eum id eius magni consequuntur delectus veritatis. Quisquam laborum illo ut ab. Ducimus in est id voluptas autem.', item.description
  end

  def test_finds_nearest_by_unit_price
    @item_repo = ItemRepository.new("test/support/items_sample.csv")
    @item_repo.collect_items
    item = @item_repo.find_one_by_unit_price(31163)
    assert_equal 7, item.id
    assert_equal 31163, item.unit_price
  end

  # def test_finds_nearest_by_merchant
  #   @item_repo = ItemRepository.new("test/support/items_sample.csv")
  #   @item_repo.collect_items
  #   item = @item_repo.find_one_by_merchant_id(1)
  #   assert_equal 5, item.id
  #   assert_equal 1, item.merchant_id
  # end

  def test_finds_all_by_id
    @item_repo = ItemRepository.new("test/support/items_sample.csv")
    @item_repo.collect_items
    item = @item_repo.find_all_by_item_id(1)
    assert_equal 1, item.first.id
    assert_equal 'Item Qui Esse', item.first.name
  end

  def test_finds_nearest_by_name
    @item_repo = ItemRepository.new("test/support/items_sample.csv")
    @item_repo.collect_items
    item = @item_repo.find_one_by_name("Item Provident At")
    assert_equal 6, item.id
    assert_equal "Item Provident At", item.name
  end

  def test_finds_nearest_by_description
    @item_repo = ItemRepository.new("test/support/items_sample.csv")
    @item_repo.collect_items
    item = @item_repo.find_one_by_description('Sunt eum id eius magni consequuntur delectus veritatis. Quisquam laborum illo ut ab. Ducimus in est id voluptas autem.')
    assert_equal 4, item.id
    assert_equal 'Sunt eum id eius magni consequuntur delectus veritatis. Quisquam laborum illo ut ab. Ducimus in est id voluptas autem.', item.description
  end

  def test_finds_nearest_by_unit_price
    @item_repo = ItemRepository.new("test/support/items_sample.csv")
    @item_repo.collect_items
    item = @item_repo.find_one_by_unit_price(31163)
    assert_equal 7, item.id
    assert_equal 31163, item.unit_price
  end

  # def test_finds_nearest_by_merchant
  #   @item_repo = ItemRepository.new("test/support/items_sample.csv")
  #   @item_repo.collect_items
  #   item = @item_repo.find_one_by_merchant_id(1)
  #   assert_equal 5, item.id
  #   assert_equal 1, item.merchant_id
  # end

end

class FakeItemRepository
  attr_accessor :item

  def find_invoices_by_invoice_id(invoice_id)
    @item
  end

end

class ItemIntegrationTest < MiniTest::Test
  def test_it_finds_related_id
    @item_repo = FakeItemRepository.new
    data = {:id => "7"}
    @item = Item.new(data, @item_repo)

    item = Array.new(5){ Item.new(data, @item_repo) }
    @item_repo.item = item
    assert_equal item, @item_repo.item
  end

  def test_it_parses_a_file_and_returns_an_array_of_instances_which_know_the_repo
    @item_repo = ItemRepository.new("test/support/items_sample.csv")
    item = @item_repo.collect_items
    assert item.first.is_a?(Item)
  end
end

class ItemParserTest < MiniTest::Test
  def test_it_parses_a_csv_of_data
    filename = "test/support/items_sample.csv"
    parsed_item = ItemParser.parse(filename)

    first = parsed_item.first
    assert_equal 1, first.id
    assert_equal 'Item Qui Esse', first.name

    fourth = parsed_item[3]
    assert_equal 4, fourth.id
    assert_equal 'Item Nemo Facere', fourth.name
  end
end
