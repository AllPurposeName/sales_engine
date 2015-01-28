class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :parent

  def initialize(my_data, my_parent)
    @id = my_data[:id].to_i
    @customer_id = my_data[:customer_id].to_i
    @merchant_id = my_data[:merchant_id].to_i
    @status = my_data[:status]
    @created_at = my_data[:created_at]
    @updated_at = my_data[:updated_at]
    @parent = my_parent
  end

  def transaction
    @parent.find_transactions_by_invoices_id(@id)
  end

  def customer
    @parent.find_customers_by_customer_id(@customer_id)
  end

  def merchant
    @parent.find_merchants_by_merchant_id(@merchant_id)
  end

  def invoice_item
    @parent.find_invoice_items_by_invoices_id(@id)
  end

end
