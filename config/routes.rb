Rails.application.routes.draw do

  match '/logout', to: 'sessions#destroy', via: [:get, :post]

  resources :restored_objects
  resources :categories

  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  Rails.application.routes.draw do
    root 'categories#index'
  end
end
