Rails.application.routes.draw do

  namespace :admin do
    root "pages#index"
    resources :users
  end

  root "pages#index"
  devise_for :users
end
