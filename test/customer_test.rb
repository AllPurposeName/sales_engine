# id first_name last_name created_at updated_at
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/customer'
# require 'byebug'

class CustomerTest < MiniTest::Test
  attr_reader :test_file
  def test_it_exists
    assert Customer
  end

  def setup
    @test_file = CSV.open("./data/customers_sample.csv", headers: true, header_converters: :symbol)
  end

  def test_it_loads_a_CSV_file
    assert @test_file
  end

  def test_it_can_read_the_file
    test_file_2 = CSV.open("./data/customers_simple_sample.csv")
    result = ["1","Joey","Ondricka","2012-03-27 14:54:09 UTC",
              "2012-03-27 14:54:09 UTC"]
    assert_equal result, test_file_2.read.flatten
  end

  def test_it_can_select_the_ID_via_symbol
    assert_equal "1", @test_file.first[:id]
  end

  def test_it_parses_first_names
    assert_equal "Joey", @test_file.first[:first_name]
  end

  def test_it_parses_last_names
    assert_equal "Ondricka", @test_file.first[:last_name]
  end

  def test_it_collects_created_at_information
    assert_equal "2012-03-27 14:54:09 UTC", @test_file.first[:created_at]
  end

  def test_it_collects_updated_at_information
    assert_equal "2012-03-27 14:54:09 UTC", @test_file.first[:updated_at]
  end

  # def test_it_can_create_an_instance_from_the_parsed_data
  #   test_customer = Customer.new
  # end
end
