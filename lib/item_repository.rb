require'pry'
require_relative '../lib/relationships'
require_relative '../lib/item_parser'
require_relative '../lib/business_intelligence'

class ItemRepository
  include BusinessIntelligence
  include Relationships
  attr_reader :file_to_parse

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def initialize(filename, our_sales_engine=nil)
    @file_to_parse = filename
    @sales_engine = our_sales_engine
    @group = []
    collect_items
  end

  def collect_items
    @group = ItemParser.parse(file_to_parse, self)
  end
end
