class Cart < ApplicationRecord
  has_many :cart_products
  has_many :products, through: :cart_products

  def cart_json
    cart_array = []
    products = [] 
      cart_products.each do |product|
        cart_array << {
              id: product.product.id,
              name: product.product.name, 
              price: product.product.price,
              description: product.product.description,
              quantity: product.quantity,
              item_total: product.total
            }
      end
      # cart_array << {total_items: total_items}
      return cart_array
  end


  def total_items 
    total = 0
    self.cart_products.each do |product|
      total += product.quantity
    end
    total
  end


  def add_product(product_id)
    cart_product = self.cart_products.find_by(product_id: product_id) 
    if cart_product
      cart_product.quantity += 1
    else
      cart_product=self.cart_products.build(product_id: product_id)
    end
    cart_product
  end

  def total_value
    value = 0
    cart_products.each do |product|
      value += product.total
    end
    value
  end

  def change_quantity(cart_product, change)
    case change
    when "up"
      cart_product.quantity +=1
    when "down"
      if cart_product.quantity > 1
        cart_product.quantity -=1
      else
        cart_product.destroy!
      end
    when "remove"
      cart_product.destroy!
    end
  end


end
