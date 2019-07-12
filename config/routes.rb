Rails.application.routes.draw do
  get 'home/index'
  match '/logout', to: 'sessions#destroy', via: [:get, :post]

  resources :restored_objects do
    resources :build, controller: 'restored_objects/build'
  end

  resources :categories
  resources :collections

  devise_for :users
  get 'users/:id' => 'users#show', as: :user

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  Rails.application.routes.draw do
    root 'home#index'
  end
end
