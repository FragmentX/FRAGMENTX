Rails.application.routes.draw do
  get 'home/index'
  match '/logout', to: 'sessions#destroy', via: [:get, :post]

  resources :restored_objects
  resources :categories
  resources :collections

  match 'users/:id' => 'users#show', via: :get

  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  Rails.application.routes.draw do
    root 'categories#index'
  end
end
