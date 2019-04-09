class UsersController < ApplicationController

    def signup
        request_body= JSON.parse(request.raw_post)
        user = User.new(:name => request_body["first_name"]+" "+request_body["last_name"], :email => request_body["email"], :password => request_body["password"])
        if user.save
            render :json => { :user_id => user.id }
        else
            return nil
        end
    end
    def login
        request_body= JSON.parse(request.raw_post)
        if !User.find_by_email(request_body["email"]).nil?
            if User.find_by_email(request_body["email"]).password == request_body["password"]
                render :json => { :user_id => User.find_by_email(request_body["email"]).id }
            else
                return nil
            end
        else
            return nil
        end
    end
end
