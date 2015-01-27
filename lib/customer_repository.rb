require'pry'
require_relative '../lib/relationships'
require_relative '../lib/customer_parser'

class CustomerRepository
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
end
