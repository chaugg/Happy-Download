Rails.application.routes.draw do
  devise_for :users, to: "users"
  get "chat/index"
  get "/static_pages/*page", to: "static_pages#show"
  mount ActionCable.server, at: "/cable"
  post "/rate", to: "rater#create", as: "rate"
  resource :users do
    resources :manage_products, only: :index
    resources :wish_lists, only: :index
    resources :commerces, only: :index
    resources :stats, only: :index
  end
  resources :products, except: :index do
    resources :order_details, only: [:new, :create]
  end
  resources :feedbacks
  resources :notifications, only: [:show,:index,:update]
  resources :wish_lists, only: [:create, :destroy]
  resources :conversations, only: [:create] do
    member do
      delete :destroy
    end
    resources :messages, only: [:create]
  end
  root "products#index"
end
