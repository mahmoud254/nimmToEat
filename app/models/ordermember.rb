class Ordermember < ApplicationRecord

    has_many:orders ,:foreign_key =>"order_id" ,dependent: :destroy
    
end
