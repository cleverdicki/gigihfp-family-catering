class Order < ApplicationRecord
  has_many :order_menus
  has_many :menus, through: :order_menus

  validates :customer_name, presence: true
  validates :customer_email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/, message: 'invalid email format'}
end
