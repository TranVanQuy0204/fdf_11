# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Product.create! name: "Food and Drink"
100.times do |n|
  name = "product-#{n}"
  price = 100 + n
  total = 100
  image = "shop/1.jpeg"
  Product.create! name: name, price: price, total: total, category_id: 1,
  image: image
end
