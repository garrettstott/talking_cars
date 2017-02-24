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
  get '/users/:username', to: 'users#show', as: 'user_show'
  get '/users/:username/messages', to: 'messages#all', as: 'all_messages'
  get '/makes', to: 'makes#index', as: 'makes'
  get '/:make_id/models', to: 'models#index', as: 'models'
  get '/:make_id/:model_id/forums', to: 'forums#index', as: 'forums'
  get '/:make_id/:model_id/:forum_id/posts', to: 'posts#index', as: 'posts'
  get '/:make_id/:model_id/:forum_id/posts/:post_id', to: 'replies#index', as: 'replies'

  # POST ROUTES
  post '/:make_id/:model_id/:forum_id/posts', to: 'posts#create', as: 'post'
  post '/:make_id/:model_id/:forum_id/posts/:post_id', to: 'replies#create', as: 'reply'
  post '/make/favorite/:id', to: 'favorites#make', as: 'favorite_make'
  post '/model/favorite/:id', to: 'favorites#model', as: 'favorite_model'
  post '/forum/favorite/:id', to: 'favorites#forum', as: 'favorite_forum'
  post '/post/favotite/:id', to: 'favorites#post', as: 'favorite_post'
  post '/users/:username/vehicle/', to: 'vehicles#create', as: 'vehicles'

  # PUT ROUTES

  # DELETE ROUTES

end
