class Group < ApplicationRecord
     validates :name, uniqueness: true
     belongs_to :user ,:foreign_key => "creator_id"
    # has_many :users, dependent: :destroy

end


