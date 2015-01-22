require'pry'
class CustomerRepository
  attr_reader :file_to_parse

  def initialize(filename, our_sales_engine=nil)
    @file_to_parse = filename
    @sales_engine = our_sales_engine
    @customers = []
  end

  def collect_customers
    @customers = CustomerParser.parse(file_to_parse)
  end

  def find_one_invoice_id(invoice_id_target)
    @customers.find do |customer|
      customer.invoice_id == invoice_id_target
    end
  end

  def find_one_authorization(authorization_target)
    @customers.find do |customer|
      customer.authorization_result == authorization_target
    end
  end

  def find_one_credit_card_number(credit_card_number_target)
    @customers.find do |customer|
      customer.credit_card_number == credit_card_number_target
    end
  end

  def find_all_by_invoice_id(invoice_id_target)
    @customers.find_all do |customer|
      customer.invoice_id == invoice_id_target
    end
  end

  def find_all_by_authorization(authorization_target)
    @customers.find_all do |customer|
      customer.authorization_result == authorization_target
    end
  end

  def find_all_by_credit_card_number(credit_card_number_target)
    @customers.find_all do |customer|
      customer.credit_card_number == credit_card_number_target
    end
  end

  private

  def all_customers
    @customers
  end

end
