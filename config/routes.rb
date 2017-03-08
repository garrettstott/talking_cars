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
  get '/:make_id/', to: 'models#index', as: 'models'
  get '/:make_id/:model_id/', to: 'forums#index', as: 'forums'
  get '/:make_id/:model_id/:forum_id/', to: 'posts#index', as: 'posts'
  get '/:make_id/:model_id/:forum_id/:post_id', to: 'replies#index', as: 'replies'
  get '/contact_us', to: 'static#contact_us', as: 'contact_us'
  get '/users/:username/posts', to: 'users#posts', as: 'user_posts'
  get '/users/:username/replies', to: 'users#replies', as: 'user_replies'

  # POST ROUTES
  post '/:make_id/:model_id/:forum_id/posts', to: 'posts#create', as: 'post'
  post '/:make_id/:model_id/:forum_id/:post_id', to: 'replies#create', as: 'reply'
  post '/make/favorite/:id', to: 'favorites#make', as: 'favorite_make'
  post '/model/favorite/:id', to: 'favorites#model', as: 'favorite_model'
  post '/forum/favorite/:id', to: 'favorites#forum', as: 'favorite_forum'
  post '/post/favotite/:id', to: 'favorites#post', as: 'favorite_post'
  post '/users/vehicles', to: 'vehicles#create', as: 'vehicles'
  post '/users/:username/posts', to: 'users#get_posts'
  post '/users/:username/replies', to: 'users#get_replies'
  post '/mailers/contact_us', to: 'mailers#contact_us', as: 'contact_us_mailer'

  # PATCH ROUTES
  patch '/users/vehicles/edit/:id', to: 'vehicles#update', as: 'vehicle'

  # DELETE ROUTES
  delete '/users/vehicles/:id', to: 'vehicles#destroy', as: 'delete_vehicle'

end
