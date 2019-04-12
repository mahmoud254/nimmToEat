class ChangeOrdermembers < ActiveRecord::Migration[5.2]
    def change
      change_table :ordermembers do |t|
        t.integer :order_id
        t.integer :member_id
        t.string  :invitation_status , default: 'invited' 
        t.string  :item
        t.integer :amount
        t.float   :price
        t.string  :comment
  
      end
    end
  end
  