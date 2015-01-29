module HigherBusinessIntelligence

  def group_customers_and_invoices(invoices)
    hurter = invoices.group_by do |invoice|
      invoice.customer_id
    end
  end

  def find_most_invoices(customers_by_invoices)
    customers_by_invoices.max_by do |invoice|
      invoice.flatten.count
    end
  end

  def find_favorite_customer(invoices)
    favorite_customers_id = invoices.first
    find_customer_by_customer_id(favorite_customers_id)
  end

  def get_favorite_customer(merchant)
    merchants_transactions = find_transactions_by_merchant_id(merchant.id)
    merchants_customers = find_customers_by_merchant_id(merchant)
    merchants_good_transactions = find_good_transactions(merchants_transactions)
    good_invoices = find_invoices_of_transactions(merchants_good_transactions)
    group_of_customers = group_customers_and_invoices(good_invoices)
    best_invoices = find_most_invoices(group_of_customers)
    find_favorite_customer(best_invoices)
  end

  def reduce_invoice_items_revenues(invoice_item_array)
    sum_of_invoice_items = invoice_item_array.inject(0) do |sum, invoice_item|
      sum += invoice_item.revenue
      sum
    end
    sum_of_invoice_items
  end


  def get_revenue(merchant, date=nil)
    merchants_transactions = find_transactions_by_merchant_id(merchant.id)
    merchants_good_transactions = find_good_transactions(merchants_transactions)
    invoice_ids = find_invoices_of_transactions(merchants_good_transactions)
    invoice_items = find_invoice_items_by_invoice_ids(invoice_ids)
    revenue = reduce_invoice_items_revenues(invoice_items)
    BigDecimal.new(revenue)
  end
end
