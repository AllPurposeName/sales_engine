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
    @parent.find_transaction_by_invoice_id(@id)
  end

  def transactions
    @parent.find_transactions_by_invoice_id(@id)
  end

  def items
    invoice_items.map do |invoice_item|
      invoice_item.items
    end.flatten


  end

  def customer
    @parent.find_customer_by_customer_id(@customer_id)
  end

  def customers
    @parent.find_customers_by_customer_id(@customer_id)
  end

  def merchant
    @parent.find_merchant_by_merchant_id(self)
  end

  def merchants
    @parent.find_merchants_by_merchant_id(self)
  end

  def invoice_item
    @parent.find_invoice_item_by_invoice_id(@id)
  end

  def invoice_items
    @parent.find_invoice_items_by_invoice_id(@id)
  end

end
