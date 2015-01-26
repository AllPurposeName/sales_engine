require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/transaction'
require_relative '../lib/transaction_repository'
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

class TransactionRepositoryTest < MiniTest::Test

  def test_finds_nearest_by_invoice_id
    @transaction_repo = TransactionRepository.new("test/support/transaction_sample.csv")
    @transaction_repo.collect_transactions
    transaction = @transaction_repo.find_one_invoice_id(5)
    assert_equal 5, transaction.invoice_id
  end

  def test_finds_nearest_by_authorization
    @transaction_repo = TransactionRepository.new("test/support/transaction_sample.csv")
    @transaction_repo.collect_transactions
    transaction = @transaction_repo.find_one_authorization("failed")
    assert_equal 6, transaction.invoice_id
    assert_equal "failed", transaction.authorization_result
  end

  def test_finds_nearest_by_credit_card_number
    @transaction_repo = TransactionRepository.new("test/support/transaction_sample.csv")
    @transaction_repo.collect_transactions
    transaction = @transaction_repo.find_one_credit_card_number(4140149827486249)
    assert_equal 10, transaction.invoice_id
    assert_equal 9, transaction.id
    assert_equal 4140149827486249, transaction.credit_card_number
  end

  def test_finds_all_by_credit_card_number
    @transaction_repo = TransactionRepository.new("test/support/transaction_sample.csv")
    @transaction_repo.collect_transactions
    transactions = @transaction_repo.find_all_by_credit_card_number(4844518708741275)
    assert_equal 6, transactions.first.invoice_id
    assert_equal 5, transactions.first.id
    assert_equal 4844518708741275, transactions.first.credit_card_number
    assert_equal "failed", transactions.first.authorization_result

    assert_equal 10, transactions[-1].invoice_id
    assert_equal 10, transactions[-1].id
    assert_equal 4844518708741275, transactions[-1].credit_card_number
    assert_equal "success", transactions[-1].authorization_result
  end

  def test_finds_all_by_authorization
    @transaction_repo = TransactionRepository.new("test/support/transaction_sample.csv")
    @transaction_repo.collect_transactions
    transactions = @transaction_repo.find_all_by_authorization("failed")
    assert_equal 6, transactions.first.invoice_id
    assert_equal 5, transactions.first.id
    assert_equal 4844518708741275, transactions.first.credit_card_number
    assert_equal "failed", transactions.first.authorization_result

    assert_equal 9, transactions[-1].invoice_id
    assert_equal 8, transactions[-1].id
    assert_equal 4540842003561938, transactions[-1].credit_card_number
    assert_equal "failed", transactions[-1].authorization_result
  end

  def test_finds_all_by_invoice_id
    @transaction_repo = TransactionRepository.new("test/support/transaction_sample.csv")
    @transaction_repo.collect_transactions
    transactions = @transaction_repo.find_all_by_invoice_id(10)
    assert_equal 10, transactions.first.invoice_id
    assert_equal 9, transactions.first.id
    assert_equal 4140149827486249, transactions.first.credit_card_number
    assert_equal "success", transactions.first.authorization_result

    assert_equal 10, transactions[-1].invoice_id
    assert_equal 10, transactions[-1].id
    assert_equal 4844518708741275, transactions[-1].credit_card_number
    assert_equal "success", transactions[-1].authorization_result
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
    other_data = {:invoices_id => "7"}

    invoices = Array.new(5){ Invoice.new(other_data, nil) }
    @transaction_repo.invoices = invoices
    assert_equal invoices, @transaction.invoices
  end

  def test_it_finds_related_credit_card_information
    @transaction_repo = FakeTransactionRepository.new
    data = {:credit_card_number => 2155676888724409}
    @transaction = Transaction.new(data, @transaction_repo)
    card_info = 2155676888724409
    assert_equal card_info, @transaction.credit_card_number
  end

  def test_it_parses_a_file_and_returns_an_array_of_instances_which_know_the_repo
    @transaction_repo = TransactionRepository.new("test/support/transaction_sample.csv")
    transactions = @transaction_repo.collect_transactions
    assert transactions.first.is_a?(Transaction)
  end

end

class TransactionParserTest < MiniTest::Test
  def test_it_parses_a_csv_of_data
    filename = "test/support/transaction_sample.csv"
    parsed_transactions = TransactionParser.parse(filename)

    first = parsed_transactions.first
    assert_equal 1, first.id
    assert_equal 1, first.invoice_id

    fourth = parsed_transactions[3]
    assert_equal 4, fourth.id
    assert_equal 5, fourth.invoice_id
  end

  def test_it_parses_credit_card_data
    filename = "test/support/transaction_sample.csv"
    parsed_transactions = TransactionParser.parse(filename)

    third = parsed_transactions[2]
    assert_equal 4354495077693036, third.credit_card_number
    assert_equal "success", third.authorization_result

    fifth = parsed_transactions[4]
    assert_equal 4844518708741275, fifth.credit_card_number
    assert_equal "failed", fifth.authorization_result
  end




end
