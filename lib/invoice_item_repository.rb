require'pry'
class InvoiceItemRepository
  attr_reader :file_to_parse

  def initialize(filename, our_sales_engine=nil)
    @file_to_parse = filename
    @sales_engine = our_sales_engine
    @invoice_items = []
  end

  def collect_invoice_items
    @invoice_items = InvoiceItemParser.parse(file_to_parse)
  end

  def find_one_by_item_id(item_id_target)
    @invoice_items.find do |invoice_item|
      invoice_item.item_id == item_id_target
    end
  end

  def find_one_by_quantity(quantity_target)
    @invoice_items.find do |invoice_item|
      invoice_item.quantity == quantity_target
    end
  end

  def find_one_by_invoice_id(invoice_id_target)
    @invoice_items.find do |invoice_item|
      invoice_item.invoice_id == invoice_id_target
    end
  end

  def find_one_by_unit_price(unit_price_target)
    @invoice_items.find do |invoice_item|
      invoice_item.unit_price == unit_price_target
    end
  end

  def find_all_by_item_id(item_id_target)
    @invoice_items.find_all do |invoice_item|
      invoice_item.item_id == item_id_target
    end
  end

  def find_all_by_unit_price(unit_price_target)
    @invoice_items.find_all do |invoice_item|
      invoice_item.unit_price == unit_price_target
    end
  end

  def find_all_by_quantity(quantity_target)
    @invoice_items.find_all do |invoice_item|
      invoice_item.quantity == quantity_target
    end
  end

  def find_all_by_invoice_id(invoice_id_target)
    @invoice_items.find_all do |invoice_item|
      invoice_item.invoice_id == invoice_id_target
    end
  end

  private

  def all_invoice_items
    @invoice_items
  end

  def random_invoice_item
    @invoice_items.sample
  end

end
