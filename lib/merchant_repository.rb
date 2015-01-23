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

  def find_one_name(name_target)
    @merchants.find do |merchant|
      merchant.name == name_target
    end
  end

  def find_one_id(id_target)
    @merchants.find do |merchant|
      merchant.id == id_target
    end
  end

  def find_all_by_name(name_target)
    @merchants.find_all do |merchant|
      merchant.name == name_target
    end
  end

  def find_all_by_id(id_target)
    @merchants.find_all do |merchant|
      merchant.id == id_target
    end
  end

  private

  def all_merchants
    @merchants
  end

end
