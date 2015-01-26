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

  def find_one_invoices_id(invoices_id_target)
    @invoices.find do |invoice|
      invoice.invoices_id == invoices_id_target
    end
  end

  def find_one_customer_id(customer_id_target)
    @invoices.find do |invoice|
      invoice.customer_id == customer_id_target
    end
  end

  def find_one_merchant_id(merchant_id_target)
    @invoices.find do |invoice|
      invoice.merchant_id == merchant_id_target
    end
  end

  def find_one_status(status_target)
    @invoices.find do |invoice|
      invoice.status == status_target
    end
  end

  def find_one_created_at(created_at_target)
    @invoices.find do |invoice|
      invoice.created_at == created_at_target
    end
  end

  def find_one_updated_at(updated_at_target)
    @invoices.find do |invoice|
      invoice.updated_at == updated_at_target
    end
  end

  def find_all_by_invoices_id(invoices_id_target)
    @invoices.find_all do |invoice|
      invoice.invoices_id == invoices_id_target
    end
  end

  def find_all_by_customer_id(customer_id_target)
    @invoices.find_all do |invoice|
      invoice.customer_id == customer_id_target
    end
  end

  def find_all_by_merchant_id(merchant_id_target)
    @invoices.find_all do |invoice|
      invoice.merchant_id == merchant_id_target
    end
  end

  def find_all_by_created_at(created_at_target)
    @invoices.find_all do |invoice|
      invoice.created_at == created_at_target
    end
  end

  def find_all_by_updated_at(updated_at_target)
    @invoices.find_all do |invoice|
      invoice.updated_at == updated_at_target
    end
  end


  private

  def all_invoices
    @invoices
  end

end
