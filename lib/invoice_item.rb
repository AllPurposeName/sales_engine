class InvoiceItem
  attr_reader :id, :invoice_id, :item_id, :quantity, :unit_price, :parent
  def initialize(my_data, my_parent)
    @id = my_data[:id].to_i
    @invoice_id = my_data[:invoice_id].to_i
    @item_id = my_data[:item_id].to_i
    @quantity = my_data[:quantity].to_i
    @unit_price = BigDecimal.new(((my_data[:unit_price])).to_s) / 100
    @parent = my_parent
  end

  def invoice
    @parent.find_invoice_by_invoice_id(self)
  end

  def item
    @parent.find_item_by_item_id(@item_id)
  end

  def items
    @parent.find_items_by_item_id(@item_id)
  end

  def revenue
    unit_price * quantity
  end
end
