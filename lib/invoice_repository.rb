require'pry'
class InvoiceRepository
  attr_reader :file_to_parse

  def initialize(filename, our_sales_engine=nil)
    @file_to_parse = filename
    @sales_engine = our_sales_engine
    @invoices = []
  end

  def collect_invoices
    @invoices = InvoiceParser.parse(file_to_parse)
  end

  def find_one_invoice_id(invoice_id_target)
    @invoices.find do |invoice|
      invoice.invoice_id == invoice_id_target
    end
  end

  def find_one_authorization(authorization_target)
    @invoices.find do |invoice|
      invoice.authorization_result == authorization_target
    end
  end

  def find_one_credit_card_number(credit_card_number_target)
    @invoices.find do |invoice|
      invoice.credit_card_number == credit_card_number_target
    end
  end

  def find_all_by_invoice_id(invoice_id_target)
    @invoices.find_all do |invoice|
      invoice.invoice_id == invoice_id_target
    end
  end

  def find_all_by_authorization(authorization_target)
    @invoices.find_all do |invoice|
      invoice.authorization_result == authorization_target
    end
  end

  def find_all_by_credit_card_number(credit_card_number_target)
    @invoices.find_all do |invoice|
      invoice.credit_card_number == credit_card_number_target
    end
  end

  private

  def all_invoices
    @invoices
  end

end
