class CustomerRepository

  def initialize(data_file=nil)
  @file = data_file
  end

  def csv_parse
    CSV.foreach('./data/customers.csv', headers: true, header_converters: :symbol) do |row|
      puts row[:last_name]



    CSV.foreach(@file, headers: true, header_converters: :symbol) do |row|
        class.new(:name, "joey")

        case row[0]
        when customer_id
          Customer.new(criteria :customer_id, :first_name, :last_name, :created_at, :updated_at)
        # when item_id
        #   Item.new(:item_id, :unit_price, etc)
        # when merchant_id
        #   Merchant.new()
        end
      end

reader criteria

customer_criteria = (:customer_id, :first_name, :last_name, :created_at, :updated_at)
item_criteria = (:item_id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
merchant_criteria = (:merchant_id, :name, :created_at, :updated_at)
invoice_criteria = (:invoice_id, :customer_id, :merchant_id, :status, :created_at, :updated_at)
invoice_items_criteria = (:invoice_item_id, :item_id, :invoice_id, :quanitity, :unit_price, :created_at, :updated_at)
transactions_criteria = (:transaction_id, :invoice_id, :credit_card_number

end
end


CSV.foreach("customers.csv", headers: true, header_converters: :symbol) do |row|
  letter = :last_name[0]
  CSV.open("customers_#{letter}.csv" 'wb') << row
end


CSV.open('newfile.csv', 'w') do |csv|
  csv << ["strings"]
end
