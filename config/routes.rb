Rails.application.routes.draw do

  # ROOT ROUTE
  root 'makes#index'

  #DEVISE ROUTES
  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    # omniauth_callbacks: 'users/omniauth_callbacks',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    unlocks: 'users/unlocks'
  }

  # GET ROUTES
  get '/contact_us', to: 'static#contact_us', as: 'contact_us'
  get '/search', to: 'search#searched', as: 'show_search'
  get '/search/:term', to: 'search#searched', as: 'searched'
  get '/users/:username', to: 'users#show', as: 'user_show'
  get '/conversations', to: 'conversations#index', as: 'conversations'
  get '/conversations/new', to: 'conversations#new', as: 'new_conversation'
  get '/conversatons/inbox', to: 'conversations#inbox', as: 'conversations_inbox'
  get '/conversations/sent', to: 'conversations#sent', as: 'conversations_sent'
  get '/conversations/trash', to: 'conversations#trash', as: 'conversations_trash'
  get '/conversations/:id', to: 'conversations#show', as: 'conversation'
  get '/users/:username/posts', to: 'users#posts', as: 'user_posts'
  get '/users/:username/replies', to: 'users#replies', as: 'user_replies'
  get '/:make_id/', to: 'models#index', as: 'models'
  get '/:make_id/:model_id/', to: 'forums#index', as: 'forums'
  get '/:make_id/:model_id/:forum_id/', to: 'posts#index', as: 'posts'
  get '/:make_id/:model_id/:forum_id/:post_id', to: 'replies#index', as: 'replies'


  # POST ROUTES
  post '/make/favorite/:id', to: 'favorites#make', as: 'favorite_make'
  post '/model/favorite/:id', to: 'favorites#model', as: 'favorite_model'
  post '/forum/favorite/:id', to: 'favorites#forum', as: 'favorite_forum'
  post '/post/favotite/:id', to: 'favorites#post', as: 'favorite_post'
  post '/users/vehicles', to: 'vehicles#create', as: 'vehicles'
  post '/conversations/new', to: 'conversations#create', as: 'create_conversation'
  post '/conversations/:id/messages', to: 'messages#create', as: 'conversation_messages'
  post '/users/:username/posts', to: 'users#get_posts'
  post '/users/:username/replies', to: 'users#get_replies'
  post '/mailers/contact_us', to: 'mailers#contact_us', as: 'contact_us_mailer'
  post '/search/', to: 'search#term', as: 'search'
  post '/search/:term/posts', to: 'search#posts'
  post '/search/:term/replies', to: 'search#replies'
  post '/:make_id/:model_id/:forum_id', to: 'posts#create', as: 'post'
  post '/:make_id/:model_id/:forum_id/:post_id', to: 'replies#create', as: 'reply'

  # PUT & PATCH ROUTES
  patch '/users/vehicles/edit/:id', to: 'vehicles#update', as: 'vehicle'
  patch '/:make_id/:model_id/:forum_id/:post_id', to: 'posts#update', as: 'update_post'
  patch '/:make_id/:model_id/:forum_id/:post_id/:reply_id', to: 'replies#update', as: 'update_reply'

  # DELETE ROUTES
  delete '/users/vehicles/:id', to: 'vehicles#destroy', as: 'delete_vehicle'
  delete '/:make_id/:model_id/:forum_id/:post_id', to: 'posts#destroy', as: 'delete_post'
  delete '/:make_id/:model_id/:forum_id/:post_id/:reply_id', to: 'replies#destroy', as: 'delete_reply'


end
