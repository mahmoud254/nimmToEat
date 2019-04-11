class GroupsController < ApplicationController
    def create_group

        request_body= JSON.parse(request.raw_post)
        
        group = Group.new(:name =>request_body["name"], :creator_id =>request_body["user_id"].to_i)
        if group.save
            render :json => {:message => "Success!" }
            else
                render :json => {:message => "failed!" }
                #return nil   
            end  
    end

    def list_groups
    

        @groups_name= Group.where("creator_id = ?",params[:id]).select("id , name" )
        
        render :json => @groups_name
       
    end

    def delete_groups
        
           @delete_record =Group.where("id = ? ",params[:id])
           if  @delete_record.present?
            if @delete_record[0].destroy
            render :json =>  {:message => "done"}
            else        
                return nil 
        end
    end

        end

    def add_member
    
        request_body= JSON.parse(request.raw_post)
        @userId = User.where("email = ?",request_body["email"]).select("id")
        if @userId.present? 
        groupmember = Groupmember.new(:group_id =>params[:id],:member_id => @userId[0]["id"].to_i)
        if groupmember.save
        render :json => { :status => :ok, :message => "Success!", :html => "...insert html...", :data => request_body }
        else
            return nil   
        end  
    else
            return nil
        #render :json => { :status => :ok, :message => "Success!", :html => "...insert html..." }
        end
        
       
    end

    def list_members

        @members_id = Groupmember.where("group_id = ?",params[:id]).select("member_id")
       
        @data_members = []
 
        @members_id.each do |t|
         @members_name = User.where("id = ?",t["member_id"]).select("name")[0]
         @data_members <<{:member_id =>t["member_id"] ,:name =>@members_name["name"]}
        end
 
        render :json =>  @data_members
 
      end
      def delete_members
        request_body= JSON.parse(request.raw_post)
           @delete_record =Groupmember.where("member_id = ? AND group_id = ? ",params[:id],request_body["group_id"].to_i)
           if  @delete_record.present?
            if @delete_record[0].destroy
            render :json =>  {:message => "done"}
            else        
                return nil 
        end
    end

        end
end
