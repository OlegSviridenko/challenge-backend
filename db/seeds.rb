puts 'Creating Products...'
mug = Product.create(code: 'MUG', name: 'Reedsy Mug', price: 6.0)
tshirt = Product.create(code: 'TSHIRT', name: 'Reedsy T-shirt', price: 15.0)
Product.create(code: 'HOODIE', name: 'Reedsy Hoodie', price: 20.0)

puts 'Creating Discounts...'
Discount.create(product: mug, condition: '(30 if COUNT >= 150) || ((COUNT / 10) * 2)')
Discount.create(product: tshirt, condition: '30 if COUNT >= 3')

puts 'Seeding done.'
