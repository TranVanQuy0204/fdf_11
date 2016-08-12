Rails.application.routes.draw do
  root "pages#index"
  devise_for :users
  resources :categories, only: :show
  resource :carts, only: :show
  resources :products do
    resources :line_items, only: [:create, :destroy, :update]
  end
  get "/auth/:provider/callback", to: "authenticate#create"
end
