# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
  # Tạo dữ liệu mẫu cho bảng "categories"
  Category.create!(name: 'Category 1')
  Category.create!(name: 'Category 2')
  
  # Tạo dữ liệu mẫu cho bảng "products"
  Product.create!(
    name: 'Product 1',
    description: 'Noi dung chi tiet 1',
    price: 19.99,
    category_id: 1
  )
  
  Product.create!(
    name: 'Product 2',
    description: 'Noi dung chi tiet 2',
    price: 29.99,
    category_id: 2
  )