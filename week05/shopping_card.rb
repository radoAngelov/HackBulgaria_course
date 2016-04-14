require 'bigdecimal'
require 'bigdecimal/util'

$MAX_LENGTH_OF_NAME = 40
$LOWEST_PRICE = '0.01'.to_d
$HIGHEST_PRICE = '999.99'.to_d
$LOWEST_QUANTITY = 1
$HIGHEST_QUANTITY = 99

class Inventory

  attr_accessor :inventory

  def initialize
    @inventory = {}
  end

  def register(product_name, price)
    if product_name.length < $MAX_LENGTH_OF_NAME && price.to_d > $LOWEST_PRICE && price.to_d < $HIGHEST_PRICE && !(inventory.has_key? product_name)
      inventory[product_name] = price
    else
      raise "Quantity or name of the product you want to add is invalid"
    end
  end

  def new_cart
    Cart.new(self)
  end

end

class Cart

  attr_accessor :cart

  def initialize(inventory)
    @cart = inventory
  end

  def add(product_name, quant = 1)
    if product_name.length < $MAX_LENGTH_OF_NAME && quant >= $LOWEST_QUANTITY && cart[product_name] + quant <= $HIGHEST_QUANTITY
      cart[product_name] = quant
    # elsif cart.has_key product_name
    else
      raise "Quantity or name of product you want to add is invalid"
    end
  end

  def total
    sum = 0
    each_pair { |key, val| sum += ( @inventory[key] * val ) }
    sum
  end

  def invoice
    puts "+------------------------------------------------+----------+"
    puts "| Name                                       qty |    price |"
    puts "+------------------------------------------------+----------+"
    each_pair do |key, val|
      puts "| " + "#{key}" + "                                    " + "#{val}" + " |     " + "@inventory[key].to_d" + " |"
    end
    puts "+------------------------------------------------+----------+"
    puts "| TOTAL                                          |     " + "#{total}" + " |" 
    puts "+------------------------------------------------+----------+"
  end
end



inventory = Inventory.new
inventory.register 'Green Tea', '1.99'
inventory.register 'Red Tea',   '2.49'
inventory.register 'Earl Grey', '1.49'

cart = inventory.new_cart

cart.add 'Green Tea'
cart.add 'Red Tea', 2
cart.add 'Green Tea', 2
p cart