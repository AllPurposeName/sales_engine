  #it's business time
module BusinessIntelligence

  def find_invoice_by_invoice_id(id)
    @sales_engine.invoice_repository.find_by_id(id.invoice_id)
  end
  def find_invoices_by_invoice_id(id)
    @sales_engine.invoice_repository.find_all_by_id(id.invoice_id)
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


  def find_merchants_by_merchant_id(merchants)
    @sales_engine.merchant_repository.find_all_by_id(merchants.merchant_id)
  end
  def find_merchant_by_merchant_id(merchant)
    @sales_engine.merchant_repository.find_by_id(merchant.merchant_id)
  end

  def find_invoice_items_by_item_id(item_id)
    @sales_engine.invoice_item_repository.find_all_by_item_id(item_id)
  end
  def find_invoice_item_by_item_id(item_id)
    @sales_engine.invoice_item_repository.find_by_item_id(item_id)
  end
  def find_invoice_items_by_invoice_id(invoice_id)
    @sales_engine.invoice_item_repository.find_all_by_invoice_id(invoice_id)
  end
  def find_invoice_item_by_invoice_id(invoice_id)
    @sales_engine.invoice_item_repository.find_by_invoice_id(invoice_id)
  end

  def find_customers_by_customer_id(customer_id)
    @sales_engine.customer_repository.find_all_by_id(customer_id)
  end
  def find_customer_by_customer_id(customer_id)
    @sales_engine.customer_repository.find_by_id(customer_id)
  end
  # def find_customers_by_customer_ids(customer_id_array)
  #   customer_id_array.map do |customer|
  #     @sales_engine.customer_repository.find_by_customer_id(customer.id)
  #   end
  # end CALLING WRONG METHOD?

  def find_transactions_by_invoice_id(invoice_id)
    @sales_engine.transaction_repository.find_all_by_invoice_id(invoice_id)
  end
  def find_transaction_by_invoice_id(invoice_id)
    @sales_engine.transaction_repository.find_by_invoice_id(invoice_id)
  end
  def find_transactions_by_invoice_ids(invoice_id_array)
    invoice_id_array.map do |invoice|
      @sales_engine.transaction_repository.find_by_invoice_id(invoice.id)
    end
      #each invoice finds all transactions
  end

  def find_invoice_items_by_invoice_ids(invoice_id_array)
    invoice_id_array.map do |invoice|
      invoice.invoice_items
    end.flatten
  end

  def find_customers_by_invoice_ids(invoice_id_array)
    invoice_id_array.map do |invoice|
      @sales_engine.customer_repository.find_by_id(invoice.customer_id)
    end
  end

  def find_good_transactions(transactions)
    transactions.delete_if do |transaction|
      transaction == nil || transaction.result == "failed"
    end
  end
  def find_customer_by_merchant_id(merchant_id)
    correlated_invoice = find_invoice_by_merchant_id(merchant_id)
    find_customer_by_customer_id(correlated_invoice.customer_id)
  end

  def find_customers_by_merchant_id(merchant)
      merchant.invoices.map do |invoice|
        invoice.customers
      end.flatten
  end
  #   correlated_invoices = find_invoices_by_merchant_id(merchant_id)
  #   find_customers_by_invoice_ids(correlated_invoices)
  # end


  def find_transaction_by_merchant_id(merchant_id)
    correlated_invoice = find_invoice_by_merchant_id(merchant_id)
    transaction = find_transaction_by_invoice_id(correlated_invoice.id)
  end

  def find_transactions_by_merchant_id(merchant_id)
    correlated_invoices = find_invoices_by_merchant_id(merchant_id)
    transactions = find_transactions_by_invoice_ids(correlated_invoices)
  end

  def find_invoices_of_transactions(transactions)
    transactions.map do |transaction|
      find_invoice_by_invoice_id(transaction)
    end
  end

end
