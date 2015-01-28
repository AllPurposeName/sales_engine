class CustomerIntelligence

  def find_invoices_from_customer(id)
    invoice_repository.find_all_by_customer_id(id)
  end

  def find_favorite_merchant_from_customer(id)
    all_transactions = find_transactions_from_customer(id)
    successes = find_successful_transactions(all_transactions)
    success_invoice_ids = successes.map(&:invoice_id)
    success_merchant_ids = success_invoice_ids.map do |invoice_id|
       invoice_repository.find_all_by_id(invoice_id).map(&:merchant_id)
    end
    fav_merch = success_merchant_ids.max_by do |id|
       success_merchant_ids.count(id)
     end
    merchant_repository.find_by_merchant_id(fav_merch.first)
  end

  def find_transactions_from_customer(id)
    all_invoices = find_invoices_from_customer(id)
    all_invoice_ids = all_invoices.map(&:id)
    all_transactions = all_invoice_ids.map do |invoice_id|
    transaction_repository.find_all_by_invoice_id(invoice_id)
  end

  def find_customer_from(id)
    customer_repository.find_by_id(id)
  end




end
