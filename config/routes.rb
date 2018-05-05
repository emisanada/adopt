# frozen_string_literal: true

Rails.application.routes.draw do
  root 'dashboard#index'

  resources :pets
  resources :users

  get 'sessions/login', to: 'sessions#login', as: 'login'
  post 'sessions/login', to: 'sessions#login', as: 'login_attempt'
  get 'sessions/logout', to: 'sessions#logout', as: 'logout'
end
