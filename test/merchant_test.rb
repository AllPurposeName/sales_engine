require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/merchant'
require_relative '../lib/merchant_parser'

class MerchantTest < MiniTest::Test

  def test_it_stores_an_id
    merchant = Merchant.new({:id => 8}, nil)
    assert_equal 8, merchant.id
  end

  def test_it_stores_an_id_as_int_only
    merchant = Merchant.new({:id => '7'}, nil)
    assert_equal 7, merchant.id
  end

  def test_it_stores_a_name
    merchant = Merchant.new({:name => 'Manny'}, nil)
    assert_equal 'Manny', merchant.name
  end
end

class MerchantRepositoryTest < MiniTest::Test

  def test_finds_nearest_by_id
    @merchant_repo = MerchantRepository.new("test/support/merchants_sample.csv")
    @merchant_repo.collect_merchants
    merchant = @merchant_repo.find_one_id(5)
    assert_equal 5, merchant.id
  end

  def test_finds_nearest_by_authorization
    @merchant_repo = MerchantRepository.new("test/support/merchants_sample.csv")
    @merchant_repo.collect_merchants
    merchant = @merchant_repo.find_one_authorization("failed")
    assert_equal 6, merchant.invoice_id
    assert_equal "failed", merchant.authorization_result
  end

  def test_finds_nearest_by_credit_card_number
    @merchant_repo = MerchantRepository.new("test/support/merchants_sample.csv")
    @merchant_repo.collect_merchants
    merchant = @merchant_repo.find_one_credit_card_number(4140149827486249)
    assert_equal 10, merchant.invoice_id
    assert_equal 9, merchant.id
    assert_equal 4140149827486249, merchant.credit_card_number
  end

  def test_finds_all_by_credit_card_number
    @merchant_repo = MerchantRepository.new("test/support/merchants_sample.csv")
    @merchant_repo.collect_merchants
    merchant = @merchant_repo.find_all_by_credit_card_number(4844518708741275)
    assert_equal 6, merchant.first.invoice_id
    assert_equal 5, merchant.first.id
    assert_equal 4844518708741275, merchant.first.credit_card_number
    assert_equal "failed", merchant.first.authorization_result

    assert_equal 10, merchant[-1].invoice_id
    assert_equal 10, merchant[-1].id
    assert_equal 4844518708741275, merchant[-1].credit_card_number
    assert_equal "success", merchant[-1].authorization_result
  end

  def test_finds_all_by_authorization
    @merchant_repo = MerchantRepository.new("test/support/merchants_sample.csv")
    @merchant_repo.collect_merchants
    merchant = @merchant_repo.find_all_by_authorization("failed")
    assert_equal 6, merchant.first.invoice_id
    assert_equal 5, merchant.first.id
    assert_equal 4844518708741275, merchant.first.credit_card_number
    assert_equal "failed", merchant.first.authorization_result

    assert_equal 9, merchant[-1].invoice_id
    assert_equal 8, merchant[-1].id
    assert_equal 4540842003561938, merchant[-1].credit_card_number
    assert_equal "failed", merchant[-1].authorization_result
  end

  def test_finds_all_by_invoice_id
    @merchant_repo = MerchantRepository.new("test/support/merchants_sample.csv")
    @merchant_repo.collect_merchants
    merchant = @merchant_repo.find_all_by_invoice_id(10)
    assert_equal 10, merchant.first.invoice_id
    assert_equal 9, merchant.first.id
    assert_equal 4140149827486249, merchant.first.credit_card_number
    assert_equal "success", merchant.first.authorization_result

    assert_equal 10, merchant[-1].invoice_id
    assert_equal 10, merchant[-1].id
    assert_equal 4844518708741275, merchant[-1].credit_card_number
    assert_equal "success", merchant[-1].authorization_result
  end

end

class FakeMerchantRepository
  attr_accessor :invoices

  def find_invoices_by_invoice_id(invoice_id)
    @invoices
  end

end

class MerchantIntegrationTest < MiniTest::Test
  def test_it_finds_related_invoice
    @merchant_repo = FakeMerchantRepository.new
    data = {:id => "7"}
    @merchant = Merchant.new(data, @merchant_repo)

    invoices = Array.new(5){ Merchant.new }
    @merchant_repo.invoices = invoices
    assert_equal invoices, @merchant.invoices
  end

  def test_it_finds_related_credit_card_information
    @merchant_repo = FakeMerchantRepository.new
    data = {:credit_card_number => 2155676888724409}
    @merchant = Merchant.new(data, @merchant_repo)
    card_info = 2155676888724409
    assert_equal card_info, @merchant.credit_card_number
  end

  def test_it_parses_a_file_and_returns_an_array_of_instances_which_know_the_repo
    @merchant_repo = MerchantRepository.new("test/support/merchants_sample.csv")
    merchant = @merchant_repo.collect_merchants
    assert merchant.first.is_a?(Merchant)
  end

end

class MerchantParserTest < MiniTest::Test
  def test_it_parses_a_csv_of_data
    filename = "test/support/merchants_sample.csv"
    parsed_merchants = MerchantParser.parse(filename)

    first = parsed_merchants.first
    assert_equal 1, first.id
    assert_equal 1, first.invoice_id

    fourth = parsed_merchants[3]
    assert_equal 4, fourth.id
    assert_equal 5, fourth.invoice_id
  end

  def test_it_parses_credit_card_data
    filename = "test/support/merchants_sample.csv"
    parsed_merchants = MerchantParser.parse(filename)

    third = parsed_merchants[2]
    assert_equal 4354495077693036, third.credit_card_number
    assert_equal "success", third.authorization_result

    fifth = parsed_merchants[4]
    assert_equal 4844518708741275, fifth.credit_card_number
    assert_equal "failed", fifth.authorization_result
  end




end
