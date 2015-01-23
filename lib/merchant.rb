class Merchant
  attr_reader :id, :name

  def initialize(my_data, my_parent)
    @id = my_data[:id].to_i
    @name = my_data[:name]
    @parent = my_parent
  end

  def item
    @parent.find_item_by_merchant_id(@id)
  end

end
