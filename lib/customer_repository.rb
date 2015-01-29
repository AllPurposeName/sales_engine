require'pry'
require 'bigdecimal/util'
require 'bigdecimal'
require_relative '../lib/relationships'
require_relative '../lib/customer_parser'
require_relative '../lib/business_intelligence'
require_relative '../lib/higher_business_intelligence'
class CustomerRepository
  include HigherBusinessIntelligence
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
    collect_customers
  end

  def collect_customers
    @group = CustomerParser.parse(file_to_parse, self)
  end

  def find_invoices_by_customer_id(id)
    @sales_engine.invoice_repository.find_all_by_customer_id(id)
  end

end
