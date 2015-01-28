class ItemIntelligence

  def find_item_from(id)
    item_repository.find_by_item_id(id)
  end

  def find_items_from(id)
    item_repository.find_all_by_item(id)
  end

  def find_items_from_merchant(id)
    item_repository.find_all_by_merchant_id(id)
  end

    def test_it_finds_most_items
      assert sales_engine.respond_to?(:find_most_items_sold_from_merchant_repository)
    end

  def find_count_items_from_merchant(id, date="all")
    count = find_successful_invoices_from_merchant(id, date).flatten.reduce(0) do |count, invoice_item|
       count + invoice_item.quantity
    end
    count
  end

  def find_most_items_sold_from_merchant_repository(x)
    merchant_ids = merchant_items.sort[-x..-1].collect {|i| i[1]}
    merchants = merchant_ids.map do |merchant_id|
      merchant_repository.find_by_merchant_id(merchant_id)
    end
    merchants.reverse
  end
end
