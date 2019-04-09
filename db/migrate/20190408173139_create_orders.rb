class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string  :meal
      t.string  :restaurant_name
      t.string  :menu_image
      t.string  :status
      t.date    :date
      t.integer  :creator_id
      t.timestamps
    end
  end
end
