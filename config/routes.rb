Rails.application.routes.draw do
  resources :follows
  devise_for :users, controllers: {confirmations: "users/confirmations" }
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  
  get "dashboard" => "dashboard#show", as: :dashboard
  # Defines the root path route ("/")
  # root "posts#index"
  resources :dashboard, only: [:show] do
    get 'edit_profile', on: :collection
    patch 'update_profile', on: :collection
  end

  resources :posts do
    collection do
      get 'archived'
    end
  end
  
  
  root 'dashboard#show'
  
  namespace :admin do
    resources :users

  end

  resources :users, only: [:index, :show] do
    member do
      post 'follow'
      post 'unfollow'
    end
  end

  ActiveAdmin.routes(self)

end
