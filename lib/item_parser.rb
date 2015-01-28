require 'CSV'
require_relative '../lib/item'
class ItemParser
  attr_reader :filename

  def self.parse(queued_file, our_repo = nil)
    new(queued_file, our_repo).create_items
  end

  def initialize(queued_file, our_repo = nil)
    @filename = queued_file
    @repository = our_repo
  end

  def create_items
    parsed_file = csv_parsing
    parsed_file.map do |row|
      Item.new(row, @repository)
    end
  end

  private

  def csv_parsing
    file = CSV.open(filename, :headers => true, :header_converters => :symbol)
  end
end
