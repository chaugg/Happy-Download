Rails.application.routes.draw do
  resources :products, except: :index
  devise_for :users
  root "static_pages#show", page: "home"
  get "/static_pages/*page", to: "static_pages#show"
  get "/manage_product", to: "static_pages#manage_product"
end
