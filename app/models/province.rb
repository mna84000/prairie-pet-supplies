class Province < ApplicationRecord
  has_many :customers, dependent: :restrict_with_error
  has_many :orders, through: :customers

  validates :name, presence: true, uniqueness: true

  validates :gst, :pst, :hst,
            numericality: { greater_than_or_equal_to: 0 }
end
