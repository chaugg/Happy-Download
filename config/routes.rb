Rails.application.routes.draw do
  get 'chat/index'
  root "products#index"
  get "/static_pages/*page", to: "static_pages#show"
  devise_for :users, to: "users"
  resource :users do
    resources :manage_products, only: :index
    resources :wish_lists, only: :index
    resources :commerces, only: :index
    resources :stats, only: :index
  end
  post "/rate", to: "rater#create", as: "rate"
  resources :products, except: :index do
    resources :order_details, only: [:new, :create]
  end
  resources :feedbacks
  resources :notifications, only: [:show,:index,:update]
  resources :wish_lists, only: [:create, :destroy]
  mount ActionCable.server, at: "/cable"
  resources :conversations, only: [:create] do
    member do
      post :close
    end
    resources :messages, only: [:create]
  end
end
