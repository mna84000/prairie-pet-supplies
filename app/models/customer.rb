class Customer < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  belongs_to :province
  has_many :orders, dependent: :destroy

  validates :first_name,
            :last_name,
            :address,
            :city,
            :postal_code,
            presence: true

  validates :postal_code,
            format: {
              with: /\A[A-Za-z]\d[A-Za-z][ -]?\d[A-Za-z]\d\z/,
              message: "must be a valid Canadian postal code"
            }

  def self.ransackable_attributes(_auth_object = nil)
    %w[
      address
      city
      created_at
      email
      encrypted_password
      first_name
      id
      last_name
      postal_code
      province_id
      remember_created_at
      reset_password_sent_at
      reset_password_token
      updated_at
    ]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[
      orders
      province
    ]
  end
end
