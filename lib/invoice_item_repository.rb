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

  def find_one_item_id(item_id_target)
    @invoice_items.find do |invoice_item|
      invoice_item.item_id == item_id_target
    end
  end

  def find_one_quantity(quantity_target)
    @invoice_items.find do |invoice_item|
      invoice_item.quantity == quantity_target
    end
  end

  def find_one_invoice_id(invoice_id_target)
    @invoice_items.find do |invoice_item|
      invoice_item.invoice_id == invoice_id_target
    end
  end

  def find_one_credit_card_number(credit_card_number_target)
    @invoice_items.find do |invoice_item|
      invoice_item.credit_card_number == credit_card_number_target
    end
  end

  def find_all_by_item_id(item_id_target)
    @invoice_items.find_all do |invoice_item|
      invoice_item.item_id == item_id_target
    end
  end

  def find_all_by_authorization(authorization_target)
    @invoice_items.find_all do |invoice_item|
      invoice_item.authorization == authorization_target
    end
  end

  def find_all_by_credit_card_number(credit_card_number_target)
    @invoice_items.find_all do |invoice_item|
      invoice_item.credit_card_number == credit_card_number_target
    end
  end

  private

  def all_invoice_items
    @invoice_items
  end

end
