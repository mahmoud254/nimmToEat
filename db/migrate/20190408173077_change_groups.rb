class ChangeGroups < ActiveRecord::Migration[5.2]
    def change
      change_table :groups do |t|
        
        t.string :creator_id
        
      end
    end
  end
  