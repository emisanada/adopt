Rails.application.routes.draw do
  root 'dashboard#index'

  resources :pets
  resources :users

  get 'sessions/login', to: 'sessions#login', as: 'login'
  get 'sessions/logout', to: 'sessions#logout', as: 'logout'
  post 'sessions/login_attempt', to: 'sessions#login_attempt', as: 'login_attempt'

end
