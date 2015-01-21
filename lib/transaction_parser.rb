require 'CSV'
class TransactionParser
  attr_reader :filename
  def initialize(queued_file)
    @filename = queued_file
  end

  def parse
    file = CSV.open(filename, :headers => true, :header_converters => :symbol)
    file.map do |row|
      Transaction.new(row, nil)
    end
  end

end
