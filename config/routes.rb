Rails.application.routes.draw do
  devise_for :users
  as :user do
    get "signin" => "devise/sessions#new"
    post "signin" => "devise/sessions#create"
    delete "signout" => "devise/sessions#destroy"
  end

  # Define a custom route for the root path
  root "users#index"

  # Add a route to the UsersController to handle the index action
  resources :users, only: [:index]
  resources :categories
  resources :products
end
