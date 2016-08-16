Rails.application.routes.draw do

  namespace :admin do
    root "pages#index"
    resources :users
    resources :categories
    resources :products
  end

  root "pages#index"
  devise_for :users
end
