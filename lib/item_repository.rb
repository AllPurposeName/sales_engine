require'pry'
class ItemRepository
  attr_reader :file_to_parse

  def initialize(filename, our_sales_engine=nil)
    @file_to_parse = filename
    @sales_engine = our_sales_engine
    @items = []
  end

  def collect_items
    @items = ItemParser.parse(file_to_parse)
  end

  def find_one_by_id(id_target)
    @items.find do |item|
      item.id == id_target
    end
  end

  def find_one_by_name(name_target)
    @items.find do |item|
      item.name == name_target
    end
  end

  def find_one_by_description(description_target)
    @items.find do |item|
      item.description == description_target
    end
  end

  def find_one_by_unit_price(unit_price_target)
    @items.find do |item|
      item.unit_price == unit_price_target
    end
  end

  def find_one_by_merchant_id(merchant_target)
    @items.find do |item|
      item.merchant_id == merchant_target
    end
  end

  def find_all_by_id(item_id_target)
    @items.find_all do |item|
      item.id == item_id_target
    end
  end

  def find_all_by_name(name_target)
    @items.find_all do |item|
      item.name == name_target
    end
  end

  def find_all_by_description(description_target)
    @items.find_all do |item|
      item.description == description_target
    end
  end

  def find_all_by_unit_price(unit_price_target)
    @items.find_all do |item|
      item.unit_price == unit_price_target
    end
  end

  def find_all_by_merchant_id(merchant_target)
    @items.find_all do |item|
      item.merchant_id == merchant_target
    end
  end


  private

  def all_transactions
    @items
  end

  def random_item
    @items.sample
  end
end
