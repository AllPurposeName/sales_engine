require'pry'
class CustomerRepository
  attr_reader :file_to_parse

  def initialize(filename, our_sales_engine=nil)
    @file_to_parse = filename
    @sales_engine = our_sales_engine
    @customers = []
  end

  def collect_customer
    @customers = CustomerParser.parse(file_to_parse)
  end

  def find_one_first_name(name_target)
    @customers.find do |customer|
      customer.first_name == name_target
    end
  end

  def find_one_last_name(name_target)
    @customers.find do |customer|
      customer.last_name == name_target
    end
  end

  def find_one_id(id_target)
    @customers.find do |customer|
      customer.id == id_target
    end
  end

  def find_all_by_first_name(name_target)
    @customers.find_all do |customer|
      customer.first_name == name_target
    end
  end

  def find_all_by_last_name(name_target)
    @customers.find_all do |customer|
      customer.last_name == name_target
    end
  end

  def find_all_by_id(id_target)
    @customers.find_all do |customer|
      customer.id == id_target
    end
  end

  private

  def all_merchants
    @customers
  end

end
