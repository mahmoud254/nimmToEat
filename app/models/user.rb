class User < ApplicationRecord

    validates :email, uniqueness: true
    has_many :groups, dependent: :destroy
    has_many :orders, dependent: :destroy
    

    has_many :friendships, :foreign_key => "user_id", 
      :class_name => "friendship"
   

   has_many :friends, :through => :friendships
end

