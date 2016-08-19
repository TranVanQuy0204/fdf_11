Rails.application.routes.draw do
  root "pages#index"
  devise_for :users
  resources :categories, only: :show
  resources :products, only: :show do
    resources :line_items, only: [:create, :destroy, :update]
  end
  resources :carts, only: :index
  get "/auth/:provider/callback", to: "authenticate#create"
  resources :customer
  resources :orders
  resources :filter_products, only: :index
  resource :address, only: :update
  resources :checkouts
  resources :users
  resources :comments
  namespace :admin do
    root "pages#index"
    resources :users
    resources :categories
    resources :products
    resources :orders
  end
end
