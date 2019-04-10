class FriendsController < ApplicationController

    def create
        request_body= JSON.parse(request.raw_post)
        @userId = User.where("email = ?",request_body["email"]).select("id")
        if @userId.present? 
        friendship = Friendship.new(:user_id =>request_body["user_id"].to_i, :friend_id =>@userId[0]["id"].to_i)
        friendship.save
        render :json => { :status => :ok, :message => "Success!", :html => "...insert html...", :data => request_body }
        else
            puts("no email is matched")
        #render :json => { :status => :ok, :message => "Success!", :html => "...insert html..." }
        end
    end

     def list_friends

       @friends_id = friendship.where("user_id = ?",params[:id]).select("friend_id")

       @friends_id.each do |t|
        @friends_name = users.where("id = ?",t).select("name")
        render :json => { :message => @friends_name}
       end

     end
end
