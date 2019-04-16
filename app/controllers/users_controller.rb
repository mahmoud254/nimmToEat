class UsersController < ApplicationController

    def signup
        request_body= JSON.parse(request.raw_post)
        user = User.new(:name => request_body["first_name"]+" "+request_body["last_name"], :email => request_body["email"], :password => request_body["password"],:image => request_body["image"])
        if user.save
            UserMailer.welcome_email(user).deliver_now
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
    def get_user_image
        @image = User.where("id = ?",params[:id]).select(:image)[0]
        render :json => {:user_image=>@image["image"]}
      end
    def forgot
        request_body= JSON.parse(request.raw_post)
        user = User.find_by(email: request_body["email"])
        require 'digest/md5'
        new_password=rand(100000..100000000).to_s
        user.password = Digest::MD5.hexdigest(new_password)
        if user.save
            UserMailer.forgot(user,new_password).deliver_now
            render :json => {message:"done"}
        else
            return nil
        end
    end
end
