#favorite_customer returns the Customer who has conducted
  #the most successful transactions
#customers_with_pending_invoices returns a collection of
  #Customer instances which have pending (unpaid) invoices.
  #An invoice is considered pending if none of it’s transactions are successful.

  def favorite_customer
    # parent.invoices with merch id   @parent.find_invoice_by_merchant_id(@id)
    # invoice ask if complete?        @invoices.find_customers_with_successful_interactions(customer_id)
      # customers = @invoices.find_customer_by_merchant_id(id)
      # successful_customers = @invoices.delete_if do |customer|
      # customers.status == failed
      # end
      #
      # most_successful(successful_customers)
      #
      # def most_successful(customers)
      # customers.max_by do |customer|
      #   customer.customer_id
      #end #([0])
      #
    # check customer with most complete?
  end
