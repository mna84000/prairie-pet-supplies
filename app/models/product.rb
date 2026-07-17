class Product < ApplicationRecord
  belongs_to :category
  has_one_attached :image

  validates :name, presence: true
  validates :description, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :stock_quantity,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :active, inclusion: { in: [ true, false ] }

  def self.ransackable_attributes(_auth_object = nil)
    %w[
      id
      name
      description
      price
      stock_quantity
      active
      category_id
      created_at
      updated_at
    ]
  end

  def self.ransackable_associations(_auth_object = nil)
    [ "category" ]
  end
end
