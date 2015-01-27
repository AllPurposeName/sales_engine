require'pry'
class TransactionRepository
  attr_reader :file_to_parse

  def initialize(filename, our_sales_engine=nil)
    @file_to_parse = filename
    @sales_engine = our_sales_engine
    @transactions = []
  end

  def collect_transactions
    @transactions = TransactionParser.parse(file_to_parse)
  end

  def find_one_by_id(id_target)
    @transactions.find do |transaction|
      transaction.id == id_target
    end
  end

  def find_one_by_invoice_id(invoice_id_target)
    @transactions.find do |transaction|
      transaction.invoice_id == invoice_id_target
    end
  end

  def find_one_by_authorization(authorization_target)
    @transactions.find do |transaction|
      transaction.authorization_result == authorization_target
    end
  end

  def find_one_by_credit_card_number(credit_card_number_target)
    @transactions.find do |transaction|
      transaction.credit_card_number == credit_card_number_target
    end
  end

  def find_all_by_id(id_target)
    @transactions.find_all do |transaction|
      transaction.id == id_target
    end
  end

  def find_all_by_invoice_id(invoice_id_target)
    @transactions.find_all do |transaction|
      transaction.invoice_id == invoice_id_target
    end
  end

  def find_all_by_authorization(authorization_target)
    @transactions.find_all do |transaction|
      transaction.authorization_result == authorization_target
    end
  end

  def find_all_by_credit_card_number(credit_card_number_target)
    @transactions.find_all do |transaction|
    transaction.credit_card_number == credit_card_number_target
  end
end

  private

  def all_transactions
    @transactions
  end

  def random_transaction
    @transactions.sample
  end

end
