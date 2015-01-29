require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require 'bigdecimal'
require 'bigdecimal/util'
require_relative '../lib/item'
require_relative '../lib/item_repository'
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
    item = Item.new({:unit_price => BigDecimal.new("75107")}, nil)
    assert_equal (BigDecimal.new("75107") / 100).to_digits, item.unit_price.to_digits
  end
end

class ItemRepositoryTest < MiniTest::Test

  def test_finds_nearest_by_id
    @item_repo = ItemRepository.new("test/support/items_sample.csv")
    @item_repo.collect_items
    item = @item_repo.find_by_id(5)
    assert_equal 5, item.id
  end

  def test_finds_nearest_by_name
    @item_repo = ItemRepository.new("test/support/items_sample.csv")
    @item_repo.collect_items
    item = @item_repo.find_by_name("Item Provident At")
    assert_equal 6, item.id
    assert_equal "Item Provident At", item.name
  end

  def test_finds_nearest_by_description
    @item_repo = ItemRepository.new("test/support/items_sample.csv")
    @item_repo.collect_items
    long_ass_description = "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro."
    item = @item_repo.find_by_description(long_ass_description)
    assert_equal 1, item.id
    assert_equal long_ass_description, item.description
  end

  def test_finds_nearest_by_unit_price
    @item_repo = ItemRepository.new("test/support/items_sample.csv")
    @item_repo.collect_items
    item = @item_repo.find_by_unit_price(BigDecimal.new("31163") / 100)
    assert_equal 7, item.id
    assert_equal "311.63", item.unit_price.to_digits
  end

  def test_finds_all_by_id
    @item_repo = ItemRepository.new("test/support/items_sample.csv")
    @item_repo.collect_items
    item = @item_repo.find_all_by_id(1)
    assert_equal 1, item.first.id
    assert_equal 'Item Qui Esse', item.first.name
    assert_equal "751.07", item.first.unit_price.to_digits

    assert_equal 1, item.last.id
    assert_equal 'Item Autem Minima', item.last.name
    assert_equal "670.76", item.last.unit_price.to_digits
  end

  def test_finds_all_by_name
    @item_repo = ItemRepository.new("test/support/items_sample.csv")
    @item_repo.collect_items
    items = @item_repo.find_all_by_name("Item Expedita")
    assert_equal 5, items.first.id
    assert_equal "687.23", items.first.unit_price.to_digits
    assert_equal "Item Expedita", items.first.name

    assert_equal 7, items.last.id
    assert_equal "311.63", items.last.unit_price.to_digits
    assert_equal "Item Expedita", items.last.name
  end

  def test_finds_all_by_description
    @item_repo = ItemRepository.new("test/support/items_sample.csv")
    @item_repo.collect_items
    long_ass_latin_description = "Sunt eum id eius magni consequuntur delectus veritatis. Quisquam laborum illo ut ab. Ducimus in est id voluptas autem."
    item = @item_repo.find_all_by_description(long_ass_latin_description)
    assert_equal 3, item.first.id
    assert_equal "323.01", item.first.unit_price.to_digits
    assert_equal long_ass_latin_description, item.first.description

    assert_equal 4, item.last.id
    assert_equal "42.91", item.last.unit_price.to_digits
    assert_equal long_ass_latin_description, item.last.description
  end

  def test_finds_all_by_unit_price
    @item_repo = ItemRepository.new("test/support/items_sample.csv")
    @item_repo.collect_items
    item = @item_repo.find_all_by_unit_price(BigDecimal.new("22582") / 100)
    assert_equal 8, item.first.id
    assert_equal "225.82", item.first.unit_price.to_digits
    assert_equal "Item Est Consequuntur", item.first.name

    assert_equal 9, item.last.id
    assert_equal "225.82", item.last.unit_price.to_digits
    assert_equal "Item Quo Magnam", item.last.name
  end
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
    items = @item_repo.collect_items
    assert items.first.is_a?(Item)
    assert_equal @item_repo, items.first.parent
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
