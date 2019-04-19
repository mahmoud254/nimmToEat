require('json')
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

    def show_orders

        request_body = JSON.parse(request.raw_post)
        @order_details=[]
        @orders = Order.select("id,meal,restaurant_name,status,creator_id")
        @member_status=Ordermember.group(["order_id","invitation_status"]).count('invitation_status')
        
        @order_invited =nil
        @order_joined ="-"
        @creator_status =nil
         #@orderDe=Order.joins(:ordermember).select("orders.id,meal,restaurant_name,status,invitation_status")#.group("order_id","invitation_status").where('orders.id = order_id').count('invitation_status')
        # render :json =>@member_status
          @orders.each do |t|
            @check = Ordermember.where("member_id = ? AND  order_id = ?",request_body["user_id"].to_i, t["id"])
            @append=false
            if @check.present?
              @append=true
            end
            
             if t["creator_id"]==request_body["user_id"].to_i
                @creator_status=true
                @append=true
             else
                @creator_status=false
             end

            @member_status.each do |key,value|

                if t["id"]==key[0]

                    if key[1]=="invited"
                    @order_invited=value
                    
                    else
                        @order_joined =value
                        end
                
                end

            end
            if @append
              @order_details <<{:id=>t["id"],:meal=>t["meal"],:restaurant=>t["restaurant_name"],:invited=>@order_invited,:joined=>@order_joined,:status=>t["status"],:creator_id=>@creator_status} 
            end
            end
             render :json => @order_details
    end


       def finish_orders


            if Order.where('id =?',params[:id]).update(:status=>"finished")
                render :json => {message:"done"}
            end

        end

        def cancel_orders
            
            @delete_record =Order.where("id =? ",params[:id])
            if @delete_record[0].destroy
                render :json =>  {:message => "done"}
                else        
                    return nil 
            end
        end

    def get_order_details
      @ordermembers = Ordermember.where("order_id = ?",params[:id]).select(:id,:member_id,:invitation_status, :item, :amount, :price, :comment)
      @orderdetails = Array.new
      @ordermembers.each do |od|
        @name_u=User.where(:id => od.member_id).select(:name)[0]
        @orderdetails << {:id=>od["id"],:name=>@name_u["name"],:member_id=>od["member_id"],:invitation_status=>od["invitation_status"],:item=>od["item"],:amount=>od["amount"],:price=>od["price"],:comment=>od["comment"]}
      end
      render :json => @orderdetails
    end

    def get_order_image
      @image = Order.where("id = ?",params[:id]).select(:menu_image)[0]
      render :json => {:menu_image=>@image["menu_image"]}
    end


    def add_order_item
      request_body = JSON.parse(request.raw_post)
      new_order_member_item = Ordermember.new(:order_id => params[:id],:member_id =>request_body["member_id"],
                            :invitation_status=>"accepted",:item =>request_body["item"],:amount=>request_body["amount"],:price=>request_body["price"],:comment=>request_body["comment"])
      if new_order_member_item.save
        @joined_item = Ordermember.where(:member_id => request_body["member_id"]).where(:order_id => params[:id]).where(:invitation_status => "invited")
        Ordermember.delete(@joined_item)
        render :json =>{:message => "done" }
      else
        render :json =>{:message => "nonsave order_item" }
        return nil
      end
    end

    def get_latest_orders
      request_body = JSON.parse(request.raw_post)
      my_orders = Ordermember.where(:member_id => request_body["user_id"]).pluck(:order_id)
      my_latest_orders = Order.where(:id=> my_orders).last(2)
      render :json => my_latest_orders
    end
    def delete_order_item
      Ordermember.delete(params[:id])
      @item = Ordermember.where(:id => params[:id])
  
      if @item != []
        return nil
      else
        render :json => "deleted"
      end
    end
  
    def delete_user_orderitems
      @items = Ordermember.where(:member_id => params[:member_id]).where(:order_id => params[:order_id]).pluck(:id)
      Ordermember.delete(@items)
      @items = Ordermember.where(:member_id => params[:member_id]).where(:order_id => params[:order_id])
      if @items != []
        render :json => @items
        return nil
      else
        render :json => "deleted"
      end
  end
end
