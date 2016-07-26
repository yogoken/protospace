Rails.application.routes.draw do
  root 'prototypes#index'
  resources :prototypes, only: [:new, :show]
end
