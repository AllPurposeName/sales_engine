require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/merchant'
require_relative '../lib/merchant_parser'

class FakeSalesEngine
  def invoice_repository
    invoice_for_test = Invoice.new({ :merchant_id => 7 }, self)
  end
  def find_one_by_merchant_id(id)
  end
end

class MerchantIntelligenceTest < MiniTest::Test

  def test_finds_invoice_by_merchant_id
    skip
    sales_engine_test = FakeSalesEngine.new
    @merchant_repo = MerchantRepository.new("data/merchants.csv", sales_engine_test)
    @merchant_repo[0].invoices(7)



  end
  #
  # def test_it_stores_an_id_as_int_only
  #   merchant = Merchant.new({:id => '7'}, nil)
  #   assert_equal 7, merchant.id
  # end
  #
  # def test_it_stores_a_name
  #   merchant = Merchant.new({:name => 'Manny'}, nil)
  #   assert_equal 'Manny', merchant.name
  # end
end
