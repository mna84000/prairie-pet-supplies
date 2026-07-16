admin = AdminUser.find_or_initialize_by(email: "admin@example.com")
admin.password = "password"
admin.password_confirmation = "password"
admin.save!

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
  created_categories[name] = Category.find_or_create_by!(name: name) do |category|
    category.description = description
  end
end

products = [
  {
    name: "Royal Canin Adult Dog Food 12kg",
    description: "Premium dry food formulated for adult dogs with balanced nutrition.",
    price: 89.99,
    stock_quantity: 20,
    active: true,
    category: "Dog Food"
  },
  {
    name: "Purina Pro Plan Indoor Cat Food 7kg",
    description: "High-protein dry food specially made for indoor adult cats.",
    price: 54.99,
    stock_quantity: 18,
    active: true,
    category: "Cat Food"
  },
  {
    name: "Kaytee Forti-Diet Parakeet Food",
    description: "Nutritious seed blend for parakeets and other small birds.",
    price: 12.99,
    stock_quantity: 35,
    active: true,
    category: "Bird Food"
  },
  {
    name: "Fluval Aquarium Starter Kit",
    description: "Complete aquarium kit with filter, LED light, and accessories.",
    price: 129.99,
    stock_quantity: 8,
    active: true,
    category: "Fish Supplies"
  },
  {
    name: "KONG Classic Dog Toy",
    description: "Durable rubber chew toy that can be filled with treats.",
    price: 16.99,
    stock_quantity: 40,
    active: true,
    category: "Pet Toys"
  },
  {
    name: "Milk-Bone Original Dog Biscuits",
    description: "Crunchy dog treats that help clean teeth while rewarding your pet.",
    price: 9.99,
    stock_quantity: 50,
    active: true,
    category: "Pet Treats"
  },
  {
    name: "Adjustable Nylon Dog Collar",
    description: "Comfortable adjustable collar with a quick-release buckle.",
    price: 18.99,
    stock_quantity: 30,
    active: true,
    category: "Collars"
  },
  {
    name: "Retractable Dog Leash 5m",
    description: "Strong retractable leash with one-button brake and locking system.",
    price: 29.99,
    stock_quantity: 22,
    active: true,
    category: "Leashes"
  },
  {
    name: "Orthopedic Memory Foam Pet Bed",
    description: "Soft memory foam bed providing extra comfort for dogs and cats.",
    price: 69.99,
    stock_quantity: 12,
    active: true,
    category: "Pet Beds"
  },
  {
    name: "Earthbath Oatmeal Pet Shampoo",
    description: "Gentle oatmeal shampoo that helps soothe dry and itchy skin.",
    price: 17.99,
    stock_quantity: 25,
    active: true,
    category: "Grooming Products"
  }
]

products.each do |product_data|
  category_name = product_data.delete(:category)

  product = Product.find_or_initialize_by(name: product_data[:name])
  product.assign_attributes(product_data)
  product.category = created_categories[category_name]
  product.save!
end

puts "Seeded #{Category.count} categories and #{Product.count} products."