class FriendsController < ApplicationController

  def create
    request_body = JSON.parse(request.raw_post)
    @userId = User.where("email = ?", request_body["email"]).select("id")
    if @userId.present?
      friendship = Friendship.new(:user_id => request_body["user_id"].to_i, :friend_id => @userId[0]["id"].to_i)
      if friendship.save
        render :json => {:status => :ok, :message => "Success!", :html => "...insert html...", :data => request_body}
      else
        return nil
      end
    else
      return nil
      #render :json => { :status => :ok, :message => "Success!", :html => "...insert html..." }
    end
  end

  def list_friends

    @friends_id = Friendship.where("user_id = ?", params[:id]).select("friend_id")

    @data_friends = []

    @friends_id.each do |t|
      @friends_name = User.where("id = ?", t["friend_id"]).select("name")[0]
      @data_friends << {:friend_id => t["friend_id"], :name => @friends_name["name"]}
    end

    render :json => @data_friends

  end

  def delete_friends
    request_body = JSON.parse(request.raw_post)
    @delete_record = Friendship.where("friend_id = ? AND user_id = ? ", params[:id], request_body["user_id"].to_i)
    if @delete_record[0].destroy
      render :json => {:message => "done"}
    else
      return nil
    end

  end


  def get_friends_activity
    request_body = JSON.parse(request.raw_post)
    order_creators = Order.pluck(:creator_id)
    activity_friends = Friendship.where(user_id: request_body["user_id"]).where(friend_id: order_creators).pluck(:friend_id)
    orders = Order.where(:creator_id => activity_friends).limit(2)
    activity = Array.new
    orders.each do |o|
      activity << [ User.where(:id => o.creator_id).select(:name), o ]
    end
    render :json => activity
  end

end
