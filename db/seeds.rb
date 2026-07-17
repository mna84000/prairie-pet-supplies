# Create or update the default admin account.
admin = AdminUser.find_or_initialize_by(email: "admin@example.com")
admin.password = "password"
admin.password_confirmation = "password"
admin.save!

# Create the product categories.
categories = {
  "Dog Food" => "Premium dry and wet food for dogs of all breeds and ages.",
  "Cat Food" => "High-quality dry and wet food designed for cats of all ages.",
  "Bird Food" => "Nutritious seed mixes, pellets, and treats for pet birds.",
  "Fish Supplies" => "Aquariums, filters, water conditioners, and fish care products.",
  "Pet Toys" => "Safe and durable toys that encourage exercise and mental stimulation.",
  "Pet Treats" => "Nutritious treats for training, rewards, and everyday care.",
  "Collars" => "Comfortable adjustable collars in different sizes and materials.",
  "Leashes" => "Durable leashes designed for safe and comfortable walks.",
  "Pet Beds" => "Soft and supportive beds for dogs and cats.",
  "Grooming Products" => "Shampoos, brushes, nail clippers, and grooming essentials."
}

created_categories = {}

categories.each do |name, description|
  category = Category.find_or_initialize_by(name: name)
  category.description = description
  category.save!

  created_categories[name] = category
end

# Product name options used to create realistic seeded records.
product_prefixes = [
  "Premium",
  "Healthy",
  "Natural",
  "Deluxe",
  "Classic",
  "Everyday",
  "Advanced",
  "Comfort",
  "Essential",
  "Professional"
]

product_types = {
  "Dog Food" => [
    "Adult Dog Food",
    "Puppy Food",
    "Chicken Dog Food",
    "Beef Dog Food"
  ],
  "Cat Food" => [
    "Indoor Cat Food",
    "Kitten Food",
    "Salmon Cat Food",
    "Chicken Cat Food"
  ],
  "Bird Food" => [
    "Parakeet Seed Mix",
    "Canary Food",
    "Parrot Pellets",
    "Bird Treat Mix"
  ],
  "Fish Supplies" => [
    "Aquarium Filter",
    "Fish Tank Light",
    "Water Conditioner",
    "Aquarium Decoration"
  ],
  "Pet Toys" => [
    "Chew Toy",
    "Rope Toy",
    "Interactive Ball",
    "Plush Toy"
  ],
  "Pet Treats" => [
    "Training Treats",
    "Dental Treats",
    "Chicken Bites",
    "Crunchy Biscuits"
  ],
  "Collars" => [
    "Nylon Collar",
    "Leather Collar",
    "Reflective Collar",
    "Adjustable Collar"
  ],
  "Leashes" => [
    "Retractable Leash",
    "Nylon Leash",
    "Training Leash",
    "Reflective Leash"
  ],
  "Pet Beds" => [
    "Memory Foam Bed",
    "Soft Cushion Bed",
    "Washable Pet Bed",
    "Orthopedic Bed"
  ],
  "Grooming Products" => [
    "Pet Shampoo",
    "Grooming Brush",
    "Nail Clippers",
    "Detangling Spray"
  ]
}

# Create or update 100 seeded products.
100.times do |index|
  category_name = product_types.keys[index % product_types.keys.length]
  category = created_categories.fetch(category_name)

  category_products = product_types.fetch(category_name)
  product_type = category_products[index % category_products.length]
  prefix = product_prefixes[index % product_prefixes.length]

  product_name = "#{prefix} #{product_type} #{index + 1}"

  product = Product.find_or_initialize_by(name: product_name)

  product.assign_attributes(
    description: Faker::Lorem.sentence(word_count: 12),
    price: Faker::Commerce.price(range: 5.0..150.0),
    stock_quantity: rand(5..75),
    active: true,
    category: category
  )

  product.save!
end

puts "Seeded #{Category.count} categories and #{Product.count} products."
