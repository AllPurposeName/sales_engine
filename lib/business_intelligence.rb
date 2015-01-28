  #it's business time
module BusinessIntelligence

  def find_invoice_by_invoice_id(id)
    @sales_engine.invoice_repository.find_by_invoice_id(id)
  end
  def find_invoices_by_invoice_id(id)
    @sales_engine.invoice_repository.find_all_by_invoice_id(id)
  end
  def find_invoice_by_merchant_id(merchant_id)
    @sales_engine.invoice_repository.find_by_merchant_id(merchant_id)
  end
  def find_invoices_by_merchant_id(merchant_id)
    @sales_engine.invoice_repository.find_all_by_merchant_id(merchant_id)
  end
  def find_invoice_by_customer_id(customer_id)
    @sales_engine.invoice_repository.find_by_customer_id(customer_id)
  end
  def find_invoices_by_customer_id(customer_id)
    @sales_engine.invoice_repository.find_all_by_customer_id(customer_id)
  end

  def find_items_by_merchant_id(merchant_id)
    @sales_engine.item_repository.find_all_by_merchant_id(merchant_id)
  end
  def find_item_by_merchant_id(merchant_id)
    @sales_engine.item_repository.find_by_merchant_id(merchant_id)
  end
  def find_items_by_item_id(id)
    @sales_engine.item_repository.find_all_by_item_id(id)
  end
  def find_item_by_item_id(id)
    @sales_engine.item_repository.find_by_item_id(id)
  end


  def find_merchants_by_merchant_id(merchant_id)
    @sales_engine.merchant_repository.find_all_by_merchant_id(merchant_id)
  end
  def find_merchant_by_merchant_id(merchant_id)
    @sales_engine.merchant_repository.find_by_merchant_id(merchant_id)
  end

  def find_invoice_items_by_item_id(item_id)
    @sales_engine.invoice_item_repository.find_all_by_item_id(item_id)
  end
  def find_invoice_item_by_item_id(item_id)
    @sales_engine.invoice_item_repository.find_all_by_item_id(item_id)
  end
  def find_invoice_items_by_invoice_id(invoice_id)
    @sales_engine.invoice_item_repository.find_all_by_invoice_id(invoice_id)
  end
  def find_invoice_item_by_invoice_id(invoice_id)
    @sales_engine.invoice_item_repository.find_all_by_invoice_id(invoice_id)
  end

  def find_customers_by_customer_id(customer_id)
    @sales_engine.customer_repository.find_all_by_customer_id(customer_id)
  end
  def find_customer_by_customer_id(customer_id)
    @sales_engine.customer_repository.find_by_customer_id(customer_id)
  end

  def find_transactions_by_invoice_id(invoice_id)
    @sales_engine.transaction_repository.find_all_by_invoice_id(invoice_id)
  end
  def find_transaction_by_invoice_id(invoice_id)
    @sales_engine.transaction_repository.find_by_invoice_id(invoice_id)
  end

end
