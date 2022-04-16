class CreateOrderMenus < ActiveRecord::Migration[7.0]
  def change
    create_table :order_menus do |t|
      t.references :order, null: false, foreign_key: true
      t.references :menu, null: false, foreign_key: true
      t.integer :quantity
      t.float :total_price

      t.timestamps
    end
  end
end
