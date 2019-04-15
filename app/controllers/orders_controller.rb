class OrdersController < ApplicationController

    def get_friends

        request_body= JSON.parse(request.raw_post)
        @user_data = User.where("email = ?",request_body["email"]).select("id,name")
        if @user_data.present?
        @friends = Friendship.where("user_id = ? AND friend_id = ?",params[:id],@user_data[0]["id"].to_i)
         if @friends.present?

            render :json => @user_data[0]

         else
            #render :json => {:message => "msh friends" }
            return nil
         end
         else
            #render :json => {:message => "no email like that here" }
            return nil
         end

    end

    def get_members

        request_body= JSON.parse(request.raw_post)
        @group_id = Group.where("name = ? AND creator_id = ?",request_body["group_name"], params[:id]).select("id")

        if @group_id.present?
         @member_data = Groupmember.joins(:user).where("group_id = ?",@group_id[0]["id"].to_i).select("member_id ,name")
         if @member_data.present?
         render :json =>  @member_data
         else
            render :json =>{:message =>"faild to retrieve data of member"}
         end
        else
            render :json =>{:message => "wrong group name" }
            #return nil
        end


    end

    def add_order
        request_body = JSON.parse(request.raw_post)
        new_order = Order.new(:meal => request_body["meal"],:restaurant_name =>request_body["restaurant_name"],
                               :menu_image=>request_body["menu_image"],:status =>request_body["status"],:creator_id=>request_body["creator_id"].to_i)

         if new_order.save

            @order_members = request_body["ordermembers"]

            @order_members.each do |t|

                new_member = Ordermember.new(:order_id => new_order["id"].to_i,:member_id=>t["id"])
                new_member.save
            end

                    render :json =>{:message => "done" }

                    # render:json =>{:message => "nonsave members" }
                    #return nil


       else
           render :json =>{:message => "nonsave order" }
            return nil
        end


    end


    def get_order_details
      @order = Order.where("id = ?",params[:id])
      render :json => @order
    end

    def invited_friends
      request_body = JSON.parse(request.raw_post)
      @invited_members  = Ordermember.where("order_id = ?",params[:id]).pluck(:member_id)
      @invited_friends = Friendship.where(user_id: request_body["user_id"]).where(friend_id: @invited_members)
    end
    def get_invited_friends
      render :json => invited_friends
    end
    def get_invited_friends_count
      render :json => invited_friends.count
    end


end
