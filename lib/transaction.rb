class Transaction
  attr_reader :id, :invoice_id, :credit_card_number, :authorization_result
  def initialize(my_data, my_parent)
    @id = my_data[:id].to_i
    @invoice_id = my_data[:invoice_id].to_i
    @credit_card_number = my_data[:credit_card_number].to_i
    @authorization_result = my_data[:result]
    @parent = my_parent

  end

  def invoices
    @parent.find_invoices_by_invoice_id(@invoice_id)
  end

end
