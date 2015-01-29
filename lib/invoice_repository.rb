require'pry'
require 'bigdecimal/util'
require 'bigdecimal'
require_relative '../lib/relationships'
require_relative '../lib/invoice_parser'
require_relative '../lib/business_intelligence'
require_relative '../lib/higher_business_intelligence'


class InvoiceRepository
  include BusinessIntelligence
  include HigherBusinessIntelligence
  include Relationships
  attr_reader :file_to_parse

  def inspect
    "#<#{self.class} #{@group.size} rows>"
  end

  def initialize(filename, our_sales_engine=nil)
    @file_to_parse = filename
    @sales_engine = our_sales_engine
    @group = []
    collect_invoices
  end

  def collect_invoices
    @group = InvoiceParser.parse(file_to_parse, self)
  end


  def find_transactions_with_customer(customer_id)
    @sales_engine.find_all_by_customer_id
  end
end
