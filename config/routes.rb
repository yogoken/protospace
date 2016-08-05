Rails.application.routes.draw do
  devise_for :users
  root 'prototypes#index'
  resources :users, only: [:show, :edit, :update]
  resources :prototypes do
    scope module: :prototypes do
      resources :likes, only: [:create, :destroy]
    end
  end
end
