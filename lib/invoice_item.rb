class InvoiceItem
  attr_reader :id, :invoice_id, :item_id, :quantity, :unit_price
  def initialize(my_data, my_parent)
    @id = my_data[:id].to_i
    @invoice_id = my_data[:invoice_id].to_i
    @item_id = my_data[:item_id].to_i
    @quantity = my_data[:quantity].to_i
    @unit_price = my_data[:unit_price]
    @parent = my_parent
  end

  def invoices
    @parent.find_invoice_item_by_id(@item_id)
  end

end
