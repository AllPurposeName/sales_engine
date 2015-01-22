customer_repo
customer
customer_sample
customer
collect_customer
customer_repository
customer_parser
parsed_customer
Customer
CustomerTest
CustomerRepository
CustomerRepositoryTest
CustomerParser
CustomerParserTest
FakeCustomerRepository
CustomerIntegrationTest

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

  def test_it_stores_an_invoice_id_as_int_only
    customer = Customer.new({:invoice_id => '45'}, nil)
    assert_equal 45, customer.invoice_id
  end
end

class CustomerRepositoryTest < MiniTest::Test

  def test_finds_nearest_by_invoice_id
    @customer_repo = CustomerRepository.new("test/support/customer_sample.csv")
    @customer_repo.collect_customer
    customer = @customer_repo.find_one_invoice_id(5)
    assert_equal 5, customer.invoice_id
  end

  def test_finds_nearest_by_authorization
    @customer_repo = CustomerRepository.new("test/support/customer_sample.csv")
    @customer_repo.collect_customer
    customer = @customer_repo.find_one_authorization("failed")
    assert_equal 6, customer.invoice_id
    assert_equal "failed", customer.authorization_result
  end

  def test_finds_nearest_by_credit_card_number
    @customer_repo = CustomerRepository.new("test/support/customer_sample.csv")
    @customer_repo.collect_customer
    customer = @customer_repo.find_one_credit_card_number(4140149827486249)
    assert_equal 10, customer.invoice_id
    assert_equal 9, customer.id
    assert_equal 4140149827486249, customer.credit_card_number
  end

  def test_finds_all_by_credit_card_number
    @customer_repo = CustomerRepository.new("test/support/customer_sample.csv")
    @customer_repo.collect_customer
    customer = @customer_repo.find_all_by_credit_card_number(4844518708741275)
    assert_equal 6, customer.first.invoice_id
    assert_equal 5, customer.first.id
    assert_equal 4844518708741275, customer.first.credit_card_number
    assert_equal "failed", customer.first.authorization_result

    assert_equal 10, customer[-1].invoice_id
    assert_equal 10, customer[-1].id
    assert_equal 4844518708741275, customer[-1].credit_card_number
    assert_equal "success", customer[-1].authorization_result
  end

  def test_finds_all_by_authorization
    @customer_repo = CustomerRepository.new("test/support/customer_sample.csv")
    @customer_repo.collect_customer
    customer = @customer_repo.find_all_by_authorization("failed")
    assert_equal 6, customer.first.invoice_id
    assert_equal 5, customer.first.id
    assert_equal 4844518708741275, customer.first.credit_card_number
    assert_equal "failed", customer.first.authorization_result

    assert_equal 9, customer[-1].invoice_id
    assert_equal 8, customer[-1].id
    assert_equal 4540842003561938, customer[-1].credit_card_number
    assert_equal "failed", customer[-1].authorization_result
  end

  def test_finds_all_by_invoice_id
    @customer_repo = CustomerRepository.new("test/support/customer_sample.csv")
    @customer_repo.collect_customer
    customer = @customer_repo.find_all_by_invoice_id(10)
    assert_equal 10, customer.first.invoice_id
    assert_equal 9, customer.first.id
    assert_equal 4140149827486249, customer.first.credit_card_number
    assert_equal "success", customer.first.authorization_result

    assert_equal 10, customer[-1].invoice_id
    assert_equal 10, customer[-1].id
    assert_equal 4844518708741275, customer[-1].credit_card_number
    assert_equal "success", customer[-1].authorization_result
  end

end

class FakeCustomerRepository
  attr_accessor :invoices

  def find_invoices_by_invoice_id(invoice_id)
    @invoices
  end

end

class CustomerIntegrationTest < MiniTest::Test
  def test_it_finds_related_invoice
    @customer_repo = FakeCustomerRepository.new
    data = {:id => "7"}
    @customer = Customer.new(data, @customer_repo)

    invoices = Array.new(5){ Invoice.new }
    @customer_repo.invoices = invoices
    assert_equal invoices, @customer.invoices
  end

  def test_it_finds_related_credit_card_information
    @customer_repo = FakeCustomerRepository.new
    data = {:credit_card_number => 2155676888724409}
    @customer = Customer.new(data, @customer_repo)
    card_info = 2155676888724409
    assert_equal card_info, @customer.credit_card_number
  end

  def test_it_parses_a_file_and_returns_an_array_of_instances_which_know_the_repo
    @customer_repo = CustomerRepository.new("test/support/customer_sample.csv")
    customer = @customer_repo.collect_customer
    assert customer.first.is_a?(Customer)
  end

end

class CustomerParserTest < MiniTest::Test
  def test_it_parses_a_csv_of_data
    filename = "test/support/customer_sample.csv"
    parsed_customer = CustomerParser.parse(filename)

    first = parsed_customer.first
    assert_equal 1, first.id
    assert_equal 1, first.invoice_id

    fourth = parsed_customer[3]
    assert_equal 4, fourth.id
    assert_equal 5, fourth.invoice_id
  end

  def test_it_parses_credit_card_data
    filename = "test/support/customer_sample.csv"
    parsed_customer = CustomerParser.parse(filename)

    third = parsed_customer[2]
    assert_equal 4354495077693036, third.credit_card_number
    assert_equal "success", third.authorization_result

    fifth = parsed_customer[4]
    assert_equal 4844518708741275, fifth.credit_card_number
    assert_equal "failed", fifth.authorization_result
  end




end
