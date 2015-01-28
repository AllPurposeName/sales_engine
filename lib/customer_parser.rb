require 'CSV'
require_relative '../lib/customer'
class CustomerParser
  attr_reader :filename

  def parse(queued_file, our_repo=nil)
    new(queued_file, our_repo).create_customers
  end

  def initialize(queued_file, our_repo=nil)
    @filename = queued_file
    @repository = our_repo
  end

  def create_customers
    parsed_file = csv_parsing
    parsed_file.map do |row|
      Customer.new(row, @repository)
    end
  end

  private

  def csv_parsing
    file = CSV.open(filename, :headers => true, :header_converters => :symbol)

  end
end

# if file nonsense
# puts CustomerParser.parse("test/support/customer_sample.csv")
