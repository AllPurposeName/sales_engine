require'pry'
require_relative '../lib/relationships'
require_relative '../lib/invoice_item_parser'
require_relative '../lib/business_intelligence'

class InvoiceItemRepository
  include BusinessIntelligence
  include Relationships
  attr_reader :file_to_parse

  def inspect
    "#<#{self.class} #{@group.size} rows>"
  end

  def initialize(filename, our_sales_engine=nil)
    @file_to_parse = filename
    @sales_engine = our_sales_engine
    @group = []
    collect_invoice_items
  end

  def collect_invoice_items
    @group = InvoiceItemParser.parse(file_to_parse, self)
  end
end
