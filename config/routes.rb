Rails.application.routes.draw do
  devise_for :users
  root "admin/users#index"

  namespace :admin do
    resources :categories
    resources :products do
      get 'html', on: :collection
    end
    resources :users, only: :index
  end
end
