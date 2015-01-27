require'pry'
class MerchantRepository
  attr_reader :file_to_parse

  def initialize(filename, our_sales_engine=nil)
    @file_to_parse = filename
    @sales_engine = our_sales_engine
    @merchants = []
  end

  def collect_merchants
    @merchants = MerchantParser.parse(file_to_parse, self)
  end

  def find_one_by_name(name_target)
    @merchants.find do |merchant|
      merchant.name == name_target
    end
  end

  def find_one_by_id(id_target)
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

  def find_invoice_by_merchant_id(id_target)
    @parent.invoice_repository.find_one_by_merchant_id(id_target)
  end

  private

  def all_merchants
    @merchants
  end

  def random_merchant
    @merchants.sample
  end

end
