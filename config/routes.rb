Rails.application.routes.draw do

  # root 'makes#index'
  root 'makes#index'

  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations',
        passwords: 'users/passwords'
      }
  get '/users/:username', to: 'users#show', as: 'user_show'
  get '/users/:username/messages', to: 'messages#all', as: 'all_messages'

  get '/makes', to: 'makes#index', as: 'makes'
  get '/:make_name/models', to: 'models#index', as: 'models'
  get '/:make_name/:model_name/forums', to: 'forums#index', as: 'forums'
  get '/:make_name/:model_name/:forum_name/posts', to: 'posts#index', as: 'posts'
  get '/:make_name/:model_name/:forum_name/:post_id/show', to: 'replies#index', as: 'replies'

end
