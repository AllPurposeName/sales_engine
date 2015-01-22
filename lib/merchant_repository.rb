require'pry'
class MerchantRepository
  attr_reader :file_to_parse

  def initialize(filename, our_sales_engine=nil)
    @file_to_parse = filename
    @sales_engine = our_sales_engine
    @merchants = []
  end

  def collect_merchants
    @merchants = MerchantParser.parse(file_to_parse)
  end

  def find_one_invoice_id(invoice_id_target)
    @merchants.find do |merchant|
      merchant.invoice_id == invoice_id_target
    end
  end

  def find_one_authorization(authorization_target)
    @merchants.find do |merchant|
      merchant.authorization_result == authorization_target
    end
  end

  def find_one_credit_card_number(credit_card_number_target)
    @merchants.find do |merchant|
      merchant.credit_card_number == credit_card_number_target
    end
  end

  def find_all_by_invoice_id(invoice_id_target)
    @merchants.find_all do |merchant|
      merchant.invoice_id == invoice_id_target
    end
  end

  def find_all_by_authorization(authorization_target)
    @merchants.find_all do |merchant|
      merchant.authorization_result == authorization_target
    end
  end

  def find_all_by_credit_card_number(credit_card_number_target)
    @merchants.find_all do |merchant|
      merchant.credit_card_number == credit_card_number_target
    end
  end

  private

  def all_merchants
    @merchants
  end

end
