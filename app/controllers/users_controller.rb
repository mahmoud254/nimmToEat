class UsersController < ApplicationController
    def signup
        # render :json => { :status => :ok, :message => "Success!", :html => "...insert html..." }
        render text: "text" , content_type: 'text/plain'
    end
end
