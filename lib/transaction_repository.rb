require 'bigdecimal'
require 'bigdecimal/util'
require'pry'
require_relative '../lib/relationships'
require_relative '../lib/transaction_parser'
require_relative '../lib/business_intelligence'
require_relative '../lib/higher_business_intelligence'


class TransactionRepository
  include HigherBusinessIntelligence
  include BusinessIntelligence
  include Relationships
  attr_reader :file_to_parse, :group

  def inspect
    "#<#{self.class} #{@group.size} rows>"
  end

  def initialize(filename, our_sales_engine=nil)
    @file_to_parse = filename
    @sales_engine = our_sales_engine
    @group = []
    collect_transactions
  end

  def collect_transactions
    @group = TransactionParser.parse(file_to_parse, self)
  end

end
