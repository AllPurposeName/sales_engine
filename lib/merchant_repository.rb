require'pry'
require_relative '../lib/relationships'
require_relative '../lib/merchant_parser'
require_relative '../lib/business_intelligence'

class MerchantRepository
  include BusinessIntelligence
  include Relationships
  attr_reader :file_to_parse, :sales_engine

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def initialize(filename, our_sales_engine=nil)
    @file_to_parse = filename
    @sales_engine = our_sales_engine
    @group = []
    collect_merchants
  end

  def collect_merchants
    @group = MerchantParser.parse(file_to_parse, self)
  end
end
