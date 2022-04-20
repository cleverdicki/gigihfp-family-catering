class Menu < ApplicationRecord
  has_many :menu_categories, dependent: :delete_all
  has_many :order_menus
  has_many :categories, through: :menu_categories
  has_many :orders, through: :order_menus

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true, length: { maximum: 150 }
  validates :price, presence: true, numericality: :only_integer, comparison: { greater_than: 0.01 }

  scope :find_price, ->(name) { where("name = ?", name).pluck(:price) }
  scope :find_id, ->(name) { where("name = ?", name).pluck(:id) }
end
