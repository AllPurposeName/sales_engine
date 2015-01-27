class InvoiceItem
  attr_reader :id, :invoice_id, :item_id, :quantity, :unit_price, :parent
  def initialize(my_data, my_parent)
    @id = my_data[:id].to_i
    @invoice_id = my_data[:invoice_id].to_i
    @item_id = my_data[:item_id].to_i
    @quantity = my_data[:quantity].to_i
    @unit_price = my_data[:unit_price].to_i
    @parent = my_parent
  end

  def invoice
    @parent.find_invoice_by_invoice_id(@invoice_id)
  end

  def item
    @parent.find_items_by_item_id(@item_id)
  end

  def items
    @parent.find_items_by_item_id(@item_id)
  end
end
