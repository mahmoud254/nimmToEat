class Order < ApplicationRecord
   
    #belongs_to :user
    #has_many :users, dependent: :destroy
    belongs_to :user ,:foreign_key => "creator_id"

    
end
