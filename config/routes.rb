Rails.application.routes.draw do
  get 'home/index'
  match '/logout', to: 'sessions#destroy', via: [:get, :post]

  resources :restored_objects
  resources :categories
  resources :collections

  devise_for :users

  root 'home#index'
end
