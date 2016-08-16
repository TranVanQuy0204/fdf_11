Rails.application.routes.draw do

  namespace :admin do
    root "pages#index"
    resources :users
    resources :categories
    resources :products
    resources :orders
  end

  root "pages#index"
  devise_for :users
end
