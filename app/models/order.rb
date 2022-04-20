class Order < ApplicationRecord
  has_many :order_menus, dependent: :delete_all
  has_many :menus, through: :order_menus

  validates :customer_name, presence: true
  validates :customer_email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/, message: 'invalid email format'}

  scope :daily_report, -> { where(created_at: (Time.now.midday - 1.day)..Time.now.midnight) }
end
