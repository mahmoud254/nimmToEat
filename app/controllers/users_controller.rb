class UsersController < ApplicationController

    def signup
        render :json => { :status => :ok, :message => "Success!", :html => "...insert html..." }
    end
    def login
        render :json => request.raw_post
    end
end
