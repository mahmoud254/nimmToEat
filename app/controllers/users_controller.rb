class UsersController < ApplicationController

    def signup
        request_body= JSON.parse(request.raw_post)
        user = User.new(:name => request_body["first_name"]+" "+request_body["last_name"], :email => request_body["email"], :password => request_body["password"])
        user.save
        render :json => { :status => :ok, :message => "Success!", :html => "...insert html...", :data => request_body }
    end
    def login
        render :json => request.raw_post
    end
end
