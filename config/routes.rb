Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users
  resources :menus
  resources :menu_items
  resources :carts
  resources :cart_items
  resources :orders
  resources :order_items
  put "/menu/setPrimary/:id" => "menus#setPrimary", as: :set_primary_menu
  root to: "home#index"
  get "/signin" => "sessions#new", as: :new_sessions
  post "/signin" => "sessions#create", as: :sessions
  delete "/signout" => "sessions#destroy", as: :destroy_session
end
