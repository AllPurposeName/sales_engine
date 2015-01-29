module Relationships

def find_by_name(name_target)
  @group.find do |merchant|
    merchant.name == name_target
  end
end

def find_all_by_name(name_target)
  @group.find_all do |merchant|
    merchant.name == name_target
  end
end

def find_by_id(id_target)
  @group.find do |transaction|
    transaction.id == id_target
  end
end

def find_all_by_id(id_target)
  @group.find_all do |transaction|
    transaction.id == id_target
  end
end





def find_by_invoice_id(invoice_id_target)
  @group.find do |transaction|
    transaction.invoice_id == invoice_id_target
  end
end
def find_all_by_invoice_id(invoice_id_target)
  @group.find_all do |transaction|
    transaction.invoice_id == invoice_id_target
  end
end

def find_by_result(result_target)
  @group.find do |transaction|
    transaction.result == result_target
  end
end
def find_all_by_result(result_target)
  @group.find_all do |transaction|
    transaction.result == result_target
  end
end

def find_by_credit_card_number(credit_card_number_target)
  @group.find do |transaction|
    transaction.credit_card_number == credit_card_number_target
  end
end
def find_all_by_credit_card_number(credit_card_number_target)
  @group.find_all do |transaction|
    transaction.credit_card_number == credit_card_number_target
  end
end

def find_by_first_name(name_target)
  @group.find do |customer|
    customer.first_name == name_target
  end
end
def find_all_by_first_name(name_target)
  @group.find_all do |customer|
    customer.first_name == name_target
  end
end


def find_by_last_name(name_target)
  @group.find do |customer|
    customer.last_name == name_target
  end
end
def find_all_by_last_name(name_target)
  @group.find_all do |customer|
    customer.last_name == name_target
  end
end




def find_by_item_id(item_id_target)
  hurter = @group.map.find do |invoice_item|
    invoice_item.item_id == item_id_target
  end
end
def find_all_by_item_id(item_id_target)
  @group.find_all do |invoice_item|
    invoice_item.item_id == item_id_target
  end
end

def find_by_quantity(quantity_target)
  @group.find do |invoice_item|
    invoice_item.quantity == quantity_target
  end
end
def find_all_by_quantity(quantity_target)
  @group.find_all do |invoice_item|
    invoice_item.quantity == quantity_target
  end
end

def find_by_invoice_id(invoice_id_target)
  @group.find do |invoice_item|
    invoice_item.invoice_id == invoice_id_target
  end
end
def find_all_by_invoice_id(invoice_id_target)
  @group.find_all do |invoice_item|
    invoice_item.invoice_id == invoice_id_target
  end
end

def find_by_unit_price(unit_price_target)
  @group.find do |invoice_item|
    invoice_item.unit_price.to_digits == unit_price_target.to_digits
  end
end
def find_all_by_unit_price(unit_price_target)
  @group.find_all do |invoice_item|
    invoice_item.unit_price.to_digits == unit_price_target.to_digits
  end
end

def find_by_customer_id(customer_id_target)
  @group.find do |customer|
    customer.customer_id == customer_id_target
  end
end

def find_all_by_customer_id(customer_id_target)
  @group.find_all do |invoice|
    invoice.customer_id == customer_id_target
  end
end

def find_by_merchant_id(merchant_id_target)
  @group.find do |invoice|
    invoice.merchant_id == merchant_id_target
  end
end
def find_all_by_merchant_id(merchant_id_target)
  @group.find_all do |invoice|
    invoice.merchant_id == merchant_id_target
  end
end

def find_by_status(status_target)
  @group.find do |invoice|
    invoice.status == status_target
  end
end
def find_all_by_status(status_target)
  @group.find_all do |invoice|
    invoice.status == status_target
  end
end

def find_by_created_at(created_at_target)
  @group.find do |invoice|
    invoice.created_at == created_at_target
  end
end
def find_all_by_created_at(created_at_target)
  @group.find_all do |invoice|
    invoice.created_at == created_at_target
  end
end

def find_by_updated_at(updated_at_target)
  @group.find do |invoice|
    invoice.updated_at == updated_at_target
  end
end
def find_all_by_updated_at(updated_at_target)
  @group.find_all do |invoice|
    invoice.updated_at == updated_at_target
  end
end


def find_by_description(description_target)
  @group.find do |item|
    item.description == description_target
  end
end
def find_all_by_description(description_target)
  @group.find_all do |item|
    item.description == description_target
  end
end

def find_by_merchant_id(merchant_target)
  @group.find do |item|
    item.merchant_id == merchant_target
  end
end
def find_all_by_merchant_id(merchant_target)
  @group.find_all do |item|
    item.merchant_id == merchant_target
  end
end

def all
  @group
end

def random
  @group.sample
end

end
