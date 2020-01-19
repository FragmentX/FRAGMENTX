Rails.application.routes.draw do
  get 'home/index'
  match '/logout', to: 'sessions#destroy', via: [:get, :post]

  resources :restored_objects do
    resources :build, controller: 'restored_objects/build'
  end

  resources :categories
  resources :collections

  devise_for :users
  get '/admin' => 'users#admin', as: :admin_panel
  get '/:username' => 'users#show', as: :user_by_name
  get 'users/:id' => 'users#show', as: :user

  post 'users/:id/approve' => 'users#approve', as: :approve_user
  post 'users/:id/deny' => 'users#deny', as: :deny_user

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  Rails.application.routes.draw do
    root 'home#index'
  end
end
