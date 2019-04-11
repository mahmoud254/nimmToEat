class CreateOrdermembers < ActiveRecord::Migration[5.2]
  def change
    create_table :ordermembers do |t|
      t.integer :order_id
      t.integer :member_id
      t.string , default: 'invited' :invitation_status
      t.string  :item
      t.integer :amount
      t.float   :price
      t.string  :comment

      t.timestamps
    end
  end
end
