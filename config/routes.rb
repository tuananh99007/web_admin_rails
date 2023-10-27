Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
     get "/users/sign_out" => "devise/sessions#destroy"
  end

  root "admin/users#index"

  namespace :admin do
    resources :categories
    resources :products
    resources :users, only: :index
  end
end
