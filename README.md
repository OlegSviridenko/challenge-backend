# Reedesy coding challenge

Ruby version - `3.2.2`
Rails version - `7.1.0.alpha`

DB - `PostgreSQL`

To install application will be enough

``bundle install``
``rails db:setup``

Or you can use docker for this one with the next commands for installation - be careful can take some time for
downloading and installing all dependencies and can take much more memory on your PC more than 1 GB

`docker-compose build`

To start application you can use default

`rails s`

or dockerized version

`docker-compose up`

### List of APIs
1. List of all products.
    This API will return List of all Products in system and here you can find id of product for next endpoint
    `curl -X GET localhost:3000/products`

2. Update product price by `id`
    Allows updating the price of a given product.
    `curl -X PATCH localhost:3000/products/1 -H "Content-Type: application/json" -d '{"product": { "price": 2.0 }}'`

3. Check the price of a given list of items with specified(in `db/seeds.rb` discounts)
    `curl -X POST localhost:3000/order -H "Content-Type: application/json" -d '{"items": "200 MUG, 4 TSHIRT, 1 HOODIE"}'`

This API already realized system of discounts through discount condition formula. Currently you can create them only through `rails console` or you can change `db/seeds.rb` to set correct value before you start application.

In perspective you can create any discounts as you wish, through simple formula with ruby syntax for example
we can use this formula

`'(30 if COUNT >= 150) || ((COUNT / 10) * 2)'`

to cover this situation for task
`Volume discount for MUG items:`
    `2% discount for 10 to 19 items`
    `4% discount for 20 to 29 items`
    `... (and so forth with discounts increasing in steps of 2%)`
    `30% discount for 150 or more items`
