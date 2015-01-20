# id first_name last_name created_at updated_at
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/customer'
# require 'byebug'

class CustomerTest < MiniTest::Test

  def test_it_exists
    assert Customer
  end

  def test_it_loads_a_CSV_file
    new_file = CSV.open("./data/customers_sample.csv")
    assert new_file
  end

  def test_it_can_read_the_file
    new_file = CSV.open("./data/customers_simple_sample.csv")
    result = ["1","Joey","Ondricka","2012-03-27 14:54:09 UTC",
              "2012-03-27 14:54:09 UTC"]
    assert_equal result, new_file.read.flatten
  end


end
