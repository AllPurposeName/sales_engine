require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/merchant_parser'
require_relative '../lib/invoice'
require_relative '../lib/invoice_repository'


class FakeSalesEngine
  attr_reader :invoice_repository
  def initialize
    @invoice_repository = InvoiceRepository.new("test/support/invoices_sample.csv")
  end

end

class MerchantIntelligenceTest < MiniTest::Test

  def test_finds_invoice_by_merchant_id
    skip
    sales_engine_test = FakeSalesEngine.new
    @merchant_repo = MerchantRepository.new("data/merchants.csv", sales_engine_test)
    a = @merchant_repo.find_invoice_by_merchant_id(@merchant_repo.random)
    binding.pry
    assert_equal 2, a.customer_id


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

  class MerchantIntelligenceIntegrationTest < Minitest::Test

    def test_it_all_works_out_ok
      skip
      assert_equal "customer123456", @sales_engine.find_favorite_customer
    end

  end
end
