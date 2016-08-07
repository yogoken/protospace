Rails.application.routes.draw do
  devise_for :users
  root 'prototypes#index'
  resources :users, only: [:show, :edit, :update]
  resources :prototypes do
    scope module: :prototypes do
      resources :likes,    only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
  end
  scope module: :prototypes do
    resources :popular,  only: [:index]
  end
end
