Rails.application.routes.draw do
  devise_for :users
  root 'prototypes#index'
  resources :users, only: [:show]
  resources :prototypes, only: [:new, :show]
end
