require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/customer'
require_relative '../lib/customer_repository'
require_relative '../lib/invoice'
require_relative '../lib/customer_parser'

class CustomerTest < MiniTest::Test

  def test_it_stores_an_id
    customer = Customer.new({:id => 8}, nil)
    assert_equal 8, customer.id
  end

  def test_it_stores_an_id_as_int_only
    customer = Customer.new({:id => '7'}, nil)
    assert_equal 7, customer.id
  end

  def test_it_stores_a_first_name
    customer = Customer.new({:first_name => 'Juan'}, nil)
    assert_equal 'Juan', customer.first_name
  end

  def test_it_stores_a_last_name
    customer = Customer.new({:last_name => 'Navarro'}, nil)
    assert_equal 'Navarro', customer.last_name
  end
end

class CustomerRepositoryTest < MiniTest::Test

  def test_finds_nearest_by_id
    @customer_repo = CustomerRepository.new("test/support/customers_sample.csv")
    @customer_repo.collect_customer
    customer = @customer_repo.find_one_id(5)
    assert_equal 5, customer.id
  end

  def test_finds_nearest_by_first_name
    @customer_repo = CustomerRepository.new("test/support/customers_sample.csv")
    @customer_repo.collect_customer
    customer = @customer_repo.find_one_first_name('Loyal')
    assert_equal 8, customer.id
    assert_equal 'Loyal', customer.first_name
  end

  def test_finds_nearest_by_last_name
    @customer_repo = CustomerRepository.new("test/support/customers_sample.csv")
    @customer_repo.collect_customer
    customer = @customer_repo.find_one_last_name('Considine')
    assert_equal 8, customer.id
    assert_equal 'Considine', customer.last_name
  end

  def test_finds_all_by_first_name
    @customer_repo = CustomerRepository.new("test/support/customers_sample.csv")
    @customer_repo.collect_customer
    customer = @customer_repo.find_all_by_first_name("Joey")
    assert_equal 1, customer[0].id
    assert_equal "Joey", customer[0].first_name

    customer = @customer_repo.find_all_by_first_name('Dejon')
    assert_equal 9, customer[-1].id
    assert_equal "Dejon", customer[-1].first_name
  end

  def test_finds_all_by_last_name
    @customer_repo = CustomerRepository.new("test/support/customers_sample.csv")
    @customer_repo.collect_customer
    customer = @customer_repo.find_all_by_last_name('Ondricka')
    assert_equal 1, customer[0].id
    assert_equal 'Ondricka', customer[0].last_name

    customer = @customer_repo.find_all_by_last_name('Fadel')
    assert_equal 9, customer[-1].id
    assert_equal 'Fadel', customer[-1].last_name
  end

  def test_finds_all_by_id
    @customer_repo = CustomerRepository.new("test/support/customers_sample.csv")
    @customer_repo.collect_customer
    customer = @customer_repo.find_all_by_id(2)
    assert_equal 2, customer.first.id
    assert_equal 'Osinski', customer.first.last_name

    assert_equal 2, customer[-1].id
    assert_equal 'Daugherty', customer[-1].last_name
  end
end

class FakeCustomerRepository
  attr_accessor :ids

  def find_invoices_by_id(id)
    @ids
  end

end

class CustomerIntegrationTest < MiniTest::Test
  def test_it_finds_related_id
    @customer_repo = FakeCustomerRepository.new
    data = {:id => "7"}
    @customer = Customer.new(data, @customer_repo)

    ids = Array.new(5){ Customer.new(data, @customer_repo) }
    @customer_repo.ids = ids
    assert_equal ids, @customer_repo.ids
  end

  def test_it_parses_a_file_and_returns_an_array_of_instances_which_know_the_repo
    @customer_repo = CustomerRepository.new('test/support/customers_sample.csv')
    customer = @customer_repo.collect_customer
    assert customer.first.is_a?(Customer)
  end
end

class CustomerParserTest < MiniTest::Test
  def test_it_parses_a_csv_of_data
    filename = "test/support/customers_sample.csv"
    parsed_customer = CustomerParser.parse(filename)

    first = parsed_customer.first
    assert_equal 1, first.id
    assert_equal 'Ondricka', first.last_name

    fourth = parsed_customer[3]
    assert_equal 4, fourth.id
    assert_equal 'Leanne', fourth.first_name
  end
end
