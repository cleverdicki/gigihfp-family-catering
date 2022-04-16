class Menu < ApplicationRecord
  has_many :menu_categories
  has_many :order_menus
  has_many :categories, through: :menu_categories
  has_many :orders, through: :order_menus
end
