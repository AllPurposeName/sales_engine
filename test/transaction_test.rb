require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/transaction'
require_relative '../lib/invoice'
require_relative '../lib/transaction_parser'

class TransactionTest < MiniTest::Test

  def test_it_stores_an_id
    transaction = Transaction.new({:id => 8}, nil)
    assert_equal 8, transaction.id
  end

  def test_it_stores_an_id_as_int_only
    transaction = Transaction.new({:id => '7'}, nil)
    assert_equal 7, transaction.id
  end

  def test_it_stores_an_invoice_id_as_int_only
    transaction = Transaction.new({:invoice_id => '45'}, nil)
    assert_equal 45, transaction.invoice_id
  end
end

class FakeTransactionRepository
  attr_accessor :invoices

  def find_invoices_by_invoice_id(invoice_id)
    @invoices
  end

end

class TransactionIntegrationTest < MiniTest::Test
  def test_it_finds_related_invoice
    @transaction_repo = FakeTransactionRepository.new
    data = {:id => "7"}
    @transaction = Transaction.new(data, @transaction_repo)

    invoices = Array.new(5){ Invoice.new }
    @transaction_repo.invoices = invoices
    assert_equal invoices, @transaction.invoices
  end
end

class TransactionParserTest < MiniTest::Test
  def test_it_parses_a_csv_of_data
    filename = "test/support/transaction_sample.csv"
    parser = TransactionParser.new(filename)
    transactions = parser.parse

    first = transactions.first
    assert_equal 1, first.id
    assert_equal 1, first.invoice_id

    fourth = transactions[3]
    assert_equal 4, fourth.id
    assert_equal 5, fourth.invoice_id
  end

  def test_it_parses_credit_card_data
    filename = "test/support/transaction_sample.csv"
    parser = TransactionParser.new(filename)
    transactions = parser.parse

    third = transactions[2]
    assert_equal 4354495077693036, third.credit_card_number
    assert_equal "success", third.authorization_result

    fifth = transactions[4]
    assert_equal 4844518708741275, fifth.credit_card_number
    assert_equal "failed", fifth.authorization_result
  end




end
