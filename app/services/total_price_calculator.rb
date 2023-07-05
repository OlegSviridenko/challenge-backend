class TotalPriceCalculator
  SAFE_REQEXP = %r{([^\d |<>?:=+\-*IFif()/])} # Fetching any symbol except digit, math operators and 'if', '?', '|', ':'
  attr_accessor :errors, :value

  def initialize
    @value = 0.0 # Total price value
    @errors = []
  end

  def call(products_list)
    fetch_products(products_list)

    Product.where(code: @products_hash.keys).includes(:discounts).each do |product|
      product_discount = calculate_product_discount(product)

      break if errors.any?

      discount_multiplier = product_discount.positive? ? (1 - product_discount / 100.0) : 1
      @value += (product.price * count(product).to_i * discount_multiplier)
    end unless errors.any?
  end

  private

  # Convert products list to hash like
  # {"MUG"=>"1", "TSHIRT"=>"1", "HOODIE"=>"1"}

  def fetch_products(products_list)
    @products_hash = products_list.split(', ').map(&:split).inject({}) do |hash, array|
      if array.size != 2 || (array.first.to_i.zero? && array.first != '0')
        errors << invalid_product_list_error
        break
      else
        hash[array.last] = array.first
        hash
      end
    end
  end

  # Fetching all discounts for product and calculate total discount. In this case, the discount is simply summed up, it
  # would be possible to take the largest of these discounts or calculate through compound interest
  def calculate_product_discount(product)
    product.discounts.inject(0) do |discount_percentage, discount|
      condition = discount.condition.gsub(Discount::COUNT_VARIABLE, count(product))
      if condition.match(SAFE_REQEXP) # Make sure that condition didn't have any unsafe operations
        errors << invalid_formula_error(product)
        break
      else
        percentage = eval(condition).to_i # It should be pretty safe by using this. Can be setted additional protection
        percentage.positive? ? discount_percentage + percentage : discount_percentage
      end
    end
  end

  def count(product)
    @products_hash[product.code]
  end

  def invalid_formula_error(product)
    "Your discount formula for #{product.code} is invalid please use only digits, math operators \
    like '() + - / *' and condition operators like 'if ? : || < > <= >= ==' \
    and use '#{Discount::COUNT_VARIABLE}' to indicate count of products"
  end

  def invalid_product_list_error
    'Invalid errors list'
  end
end
