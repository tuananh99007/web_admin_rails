Rails.application.routes.draw do
  devise_for :users, path: 'auth',
    path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      password: 'secret',
      confirmation: 'verification',
      unlock: 'unblock',
      registration: 'register',
      sign_up: 'cmon_let_me_in'
    }

  devise_scope :user do
    get "signin", to: "devise/sessions#new", as: :new_user_session
    post "signin", to: "devise/sessions#create", as: :user_session
    delete "signout", to: "devise/sessions#destroy", as: :destroy_user_session
  end

  root "users#index"

  resources :users, only: [:index]
  resources :categories
  resources :products
end
