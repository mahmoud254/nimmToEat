Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post "/users", to: 'users#signup'
  post "/users/login", to: 'users#login'
  post "/users/signup", to: 'users#signup'
  post "/users/forgot", to: 'users#forgot'

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

  post "/orders/show", to: 'orders#show_orders'


  #################### new commits for order page####################
  #
  post "/orders/latest", to: 'orders#get_latest_orders' #takes {"user_id":2}
  #get order details
  get "/orders/:id", to: 'orders#get_order_details'

  post "/orders/:id/invitedfriends", to: 'orders#get_invited_friends' #takes {"user_id":2}
  post "/orders/:id/invitedfriendscount", to: 'orders#get_invited_friends_count' #takes {"user_id":2}


  post "/orders/:id/joinedfriends", to: 'orders#get_joined_friends' #takes {"user_id":2}
  post "/orders/:id/joinedfriendscount", to: 'orders#get_joined_friends_count' #takes {"user_id":2}


  post "/orders/:id/add_item", to: 'orders#add_order_item' #takes {"user_id":2}


end

