Rails.application.routes.draw do
  get 'home/index'
  match '/logout', to: 'sessions#destroy', via: [:get, :post]

  resources :restored_objects
  resources :categories

  devise_for :users

  root 'home#index'
end
