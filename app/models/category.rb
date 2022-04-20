class Category < ApplicationRecord
  has_many :menu_categories
  has_many :menus, through: :menu_categories

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  scope :find_id, ->(name) { where("name = ?", name).pluck(:id) }
end
