class Groupmember < ApplicationRecord

    belongs_to :user ,:foreign_key => "member_id" 
    belongs_to :group ,:foreign_key => "group_id", :dependent => :destroy
    validates_uniqueness_of :group_id, :scope => :member_id
end
