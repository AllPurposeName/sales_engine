require 'CSV'
require_relative '../lib/invoice'
class InvoiceParser
  attr_reader :filename

  def self.parse(queued_file, our_repo=nil)
    new(queued_file, our_repo).create_invoices
  end

  def initialize(queued_file, our_repo=nil)
    @filename = queued_file
    @repository = our_repo
  end

  def create_invoices
    parsed_file = csv_parsing
    parsed_file.map do |row|
      Invoice.new(row, @repository)
    end
  end

  private

  def csv_parsing
    file = CSV.open(filename, :headers => true, :header_converters => :symbol)

  end
end

# if file nonsense
# puts InvoiceParser.parse("test/support/invoice_sample.csv")
