class Item
  attr_reader :id, :name, :description, :unit_price, :merchant_id, :parent

  def initialize(my_data, my_parent)
    @id = my_data[:id].to_i
    @name = my_data[:name]
    @description = my_data[:description]
    @unit_price = BigDecimal.new(((my_data[:unit_price])).to_s) / 100
    @merchant_id = my_data[:merchant_id].to_i
    @parent = my_parent
  end

  def invoices
    @parent.find_invoices_by_id(@id)
  end

  def invoice_items
    @parent.find_invoice_items_by_item_id(@id)
  end

  def merchant
    @parent.find_merchant_by_merchant_id(self)
  end

  def item_id
    @id
  end
end
