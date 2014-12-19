Rails.application.routes.draw do
  devise_for :users, skip: [:sessions, :passwords, :registrations, :confirmations, :unlocks]

  devise_scope :user do
    get 'login' => 'devise/sessions#new', as: :new_user_session
    post 'login' => 'devise/sessions#create', as: :user_session
    delete 'logout' => 'devise/sessions#destroy', as: :destroy_user_session

    post 'update-password' => 'devise/passwords#create', as: :user_password
    get 'reset-password' => 'devise/passwords#new', as: :new_user_password
    get 'update-password' => 'devise/passwords#edit', as: :edit_user_password
    put 'update-password' => 'devise/passwords#update'
  end

  authenticated :user do
    namespace :admin do
      resources :designations

      resources :documents

      resources :offices

      resources :pages

      resources :pictures

      resources :posts

      resources :users

      root to: 'admin#index'
    end

    namespace :agents do
      resources :documents

      root to: 'agents#index'
    end
  end

  resources :posts, :only => [:index, :show]

  get '/sitemap.xml' => 'sitemap#index', :as => :sitemap, :format => :xml

  root to: 'pages#index'

  get '*fulL_path' => 'pages#show'
end
