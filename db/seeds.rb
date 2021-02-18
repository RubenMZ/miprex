# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def generate_price_objects(value, product, supermarkets)
  supermarkets.map do |supermarket|
    offset = rand(0.01..0.05).round(2)
    {value: value+offset, product: product, supermarket: supermarket}
  end
end

products = Product.create([
  {name: 'Coca Cola lata 33 cl.', quantity: 0.33, unit: 'L'}, # 0,67
  {name: 'Coca Cola botella 2 l.', quantity: 2, unit: 'L'}, # 0,67
  {name: "Patatas fritas sabor campesinas Lay's 250 g.", quantity: 0.25, unit: 'kg'}, # 2,13
  {name: "Patatas fritas sabor campesinas Lay's 160 g.", quantity: 0.16, unit: 'kg'}, # 1,56
  {name: 'Lavavajillas máquina Todo en 1 Max Calgonit Finish 65 ud', quantity: 65, unit: 'ud'}, # 12,74
  {name: 'Patatas fritas onduladas sabor jamón Ruffles 160 g.', quantity: 0.16, unit: 'kg'} # 1,48
])

supermarkets = Supermarket.create([
  {name: 'Mercadona'},
  {name: 'Deza'},
  {name: 'Carrefour'},
  {name: 'Lidl'},
  {name: 'Dia'}
])

price_objects = generate_price_objects(0.60, products[0], supermarkets)
price_objects += generate_price_objects(1.80, products[1], supermarkets)
price_objects += generate_price_objects(2, products[2], supermarkets)
price_objects += generate_price_objects(1.5, products[3], supermarkets)
price_objects += generate_price_objects(12.50, products[4], supermarkets)
price_objects += generate_price_objects(1.48, products[5], supermarkets)

Price.create(price_objects)

