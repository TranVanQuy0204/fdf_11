Rails.application.routes.draw do
  root "pages#index"
  devise_for :users
  resources :categories, only: :show
  resource :carts, only: :show
  resources :products, only: [:show] do
    resources :line_items, only: [:create, :destroy, :update]
  end
  get "/auth/:provider/callback", to: "authenticate#create"
  resources :customer
  resources :filter_products, only: :index
  namespace :admin do
    root "pages#index"
    resources :users
    resources :categories
    resources :products
    resources :orders
  end
end
