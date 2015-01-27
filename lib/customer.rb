class Customer
  attr_reader :id, :first_name, :last_name, :parent

  def initialize(my_data, my_parent)
    @id = my_data[:id].to_i
    @first_name = my_data[:first_name]
    @last_name = my_data[:last_name]
    @parent = my_parent
  end

  def invoice
    @parent.find_invoice_by_customer_id(@id)
  end
end
