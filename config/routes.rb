Rails.application.routes.draw do
  root 'dashboard#index'

  resources :pets
  resources :users
end
