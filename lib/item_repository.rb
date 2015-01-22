require'pry'
class ItemRepository
  attr_reader :file_to_parse

  def initialize(filename, our_sales_engine=nil)
    @file_to_parse = filename
    @sales_engine = our_sales_engine
    @items = []
  end

  def collect_transactions
    @items = ItemParser.parse(file_to_parse)
  end

  def find_one_invoice_id(invoice_id_target)
    @items.find do |item|
      item.invoice_id == invoice_id_target
    end
  end

  def find_one_authorization(authorization_target)
    @items.find do |item|
      item.authorization_result == authorization_target
    end
  end

  def find_one_credit_card_number(credit_card_number_target)
    @items.find do |item|
      item.credit_card_number == credit_card_number_target
    end
  end

  def find_all_by_invoice_id(invoice_id_target)
    @items.find_all do |item|
      item.invoice_id == invoice_id_target
    end
  end

  def find_all_by_authorization(authorization_target)
    @items.find_all do |item|
      item.authorization_result == authorization_target
    end
  end

  def find_all_by_credit_card_number(credit_card_number_target)
    @items.find_all do |item|
      item.credit_card_number == credit_card_number_target
    end
  end

  private

  def all_transactions
    @items
  end

end
