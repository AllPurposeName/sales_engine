class Merchant
  attr_reader :id, :name, :parent

  def initialize(my_data, my_parent)
    @id = my_data[:id].to_i
    @name = my_data[:name]
    @parent = my_parent
  end

  def item
    @parent.find_item_by_merchant_id(@id)
  end

  def items
    @parent.find_items_by_merchant_id(@id)
  end

  def invoice
    @parent.find_invoice_by_merchant_id(@id)
  end

  def invoices
    @parent.find_invoices_by_merchant_id(@id)
  end

end
