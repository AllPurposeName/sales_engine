require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/transaction'
require_relative '../lib/invoice'
class TransactionTest < MiniTest::Test

end

class FakeTransactionRepository

end

class TransactionIntegrationTest < MiniTest::Test
  def test_it_finds_related_invoice
    trans_repo = FakeTransactionRepository.new
    invoices = Array.new(5){ Invoice.new }
    assert_equal invoices, @transaction.invoices
  end
end
