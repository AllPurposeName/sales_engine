class Item
  attr_reader :id, :name, :description, :unit_price, :merchant_id

  def initialize(my_data, my_parent)
    @id = my_data[:id].to_i
    @name = my_data[:name]
    @description = my_data[:description]
    @unit_price = my_data[:unit_price].to_i
    @merchant_id = my_data[:merchant_id]
    @parent = my_parent
  end

  def invoices
    @parent.find_invoices_by_invoice_id(@invoice_id)
  end
end
