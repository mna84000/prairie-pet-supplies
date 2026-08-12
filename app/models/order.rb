class Order < ApplicationRecord
  belongs_to :customer

  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  validates :subtotal,
            :gst,
            :pst,
            :hst,
            :total,
            numericality: { greater_than_or_equal_to: 0 }

 validates :status, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[
      created_at
      customer_id
      gst
      hst
      id
      pst
      status
      subtotal
      total
      updated_at
    ]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[
      customer
      order_items
      products
    ]
  end
end
