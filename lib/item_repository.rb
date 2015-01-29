require'pry'
require 'bigdecimal/util'
require 'bigdecimal'
require_relative '../lib/relationships'
require_relative '../lib/item_parser'
require_relative '../lib/business_intelligence'
require_relative '../lib/higher_business_intelligence'


class ItemRepository
  include HigherBusinessIntelligence
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
