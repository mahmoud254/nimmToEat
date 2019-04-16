Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post "/users", to: 'users#signup'
  post "/users/login", to: 'users#login'
  post "/users/signup", to: 'users#signup'
  post "/users/forgot", to: 'users#forgot'
  get "/users/:id/getimage" , to: 'users#get_user_image'

  post "/friends", to: 'friends#create'
  post "/friends/activity", to: 'friends#get_friends_activity' #takes {user_id:2}
  get "/friends/:id", to: 'friends#list_friends'
  post "/friends/:id/delete", to: 'friends#delete_friends'

  post "/groups", to: 'groups#create_group'
  get "/groups/users/:id", to: 'groups#list_groups'
  get "/groups/:id/delete", to: 'groups#delete_groups'
  post "/groups/:id/addmember", to: 'groups#add_member'
  get "/groups/:id", to: 'groups#list_members'
  post "/groups/members/:id/delete", to: 'groups#delete_members'


  post "/orders", to:'orders#add_order'
  post "/orders/:id/getfriend" ,to:'orders#get_friends'
  post "/orders/:id/getmembers",to:'orders#get_members'

  post "/orders/show",to:'orders#show_orders'
  get "/orders/:id/finish",to:'orders#finish_orders'
  get "/orders/:id/cancel",to:'orders#cancel_orders'
  

 

  #################### new commits for order page####################
  #
  post "/orders/latest", to: 'orders#get_latest_orders' #takes {"user_id":2}
  #get order details
  get "/orders/:id", to: 'orders#get_order_details' 
  get "/orders/:id/getimage" , to: 'orders#get_order_image'
  post "/orders/:id/add_item", to: 'orders#add_order_item' #takes {"user_id":2}

  get "/orders/:id/deleteItem", to: 'orders#delete_order_item'
  get "/orders/:order_id/removeMember/:member_id", to: 'orders#delete_user_orderitems'


end

