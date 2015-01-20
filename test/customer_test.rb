# id first_name last_name created_at updated_at
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require '../lib/customer'
# require 'byebug'

class CustomerTest < MiniTest::Test

  def test_it_exists
    assert Customer
  end

  def test_it_loads_a_CSV_file
    new_file = CSV.open("../data/customers_sample.csv")
    assert new_file
  end

  def test_it_can_read_the_file
    new_file = CSV.open("../data/customers_sample.csv")
    new_file.readline
    assert new_file.chars[0] = "i"
  end


end
