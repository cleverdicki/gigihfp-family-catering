class Menu < ApplicationRecord
  has_many :menu_categories
  has_many :order_menus
  has_many :categories, through: :menu_categories
  has_many :orders, through: :order_menus

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true, length: { maximum: 150 }
  validates :price, presence: true, numericality: :only_integer, comparison: { greater_than: 0.01 }
end
