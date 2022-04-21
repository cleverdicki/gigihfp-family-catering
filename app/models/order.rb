class Order < ApplicationRecord
  has_many :order_menus, dependent: :delete_all
  has_many :menus, through: :order_menus

  validates :customer_name, presence: true
  validates :customer_email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/, message: 'invalid email format'}

  time = Time.now.midnight
  morning_time = time + (60 * 60 * 5)
  evening_time = time + (60 * 60 * 17)

  scope :daily_report, -> { where(created_at: morning_time..evening_time) }
  scope :find_price, -> (order_id) { where("id = ?", order_id).pluck(:total_price) }
end
