require'pry'
require_relative '../lib/relationships'
require_relative '../lib/invoice_item_parser'

class InvoiceItemRepository
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


  def find_items_by_item_id(id)
    @parent.item_repository.find_all_by_item_id(id)
  end
end
