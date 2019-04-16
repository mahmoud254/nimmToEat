class Ordermember < ApplicationRecord

    has_many:orders ,:foreign_key =>"id" ,dependent: :destroy
    
end
