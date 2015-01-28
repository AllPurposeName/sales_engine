require'pry'
require_relative '../lib/relationships'
require_relative '../lib/transaction_parser'

class TransactionRepository
  include Relationships
  attr_reader :file_to_parse

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
