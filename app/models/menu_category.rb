class MenuCategory < ApplicationRecord
  belongs_to :menu, optional: true
  belongs_to :category, optional: true

  scope :find_data, -> (menu_id, category_id) { where("menu_id = ?", menu_id).where("category_id = ?", category_id) }
end
