# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

products = Product.create([
  {name: 'Patatas Matutano', quantity: 0.17, unit: 'kg'},
  {name: 'Lata CocaCola', quantity: 0.33, unit: 'L'},
  {name: 'Lavajillas Finish', quantity: 100, unit: 'caps'}
])

supermarkets = Supermarket.create([
  {name: 'Mercadona'},
  {name: 'Deza'},
  {name: 'Carrefour'}
])

prices = Price.create([
  {value: 1.19, product: products[0], supermarket: supermarkets[0]},
  {value: 1.20, product: products[0], supermarket: supermarkets[1]},
  {value: 1.20, product: products[0], supermarket: supermarkets[2]},
  {value: 0.70, product: products[1], supermarket: supermarkets[0]},
  {value: 0.69, product: products[1], supermarket: supermarkets[1]},
  {value: 0.71, product: products[1], supermarket: supermarkets[2]},
  {value: 20.00, product: products[2], supermarket: supermarkets[0]},
  {value: 21.90, product: products[2], supermarket: supermarkets[1]},
  {value: 23.50, product: products[2], supermarket: supermarkets[2]}
])
