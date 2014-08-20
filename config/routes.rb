Rails.application.routes.draw do
  root 'pages#home'
  resources :sessions, only: [:new, :create, :destroy]
  resources :games, only: [:new, :create, :show, :index, :edit, :destroy, :update] do
    resources :tickets, only: [:new, :create]
    resources :guides, only: [:new, :create]
    resources :documents, only: [:show, :new, :create, :index]
  end
  resources :tickets, only: [:index, :edit, :update, :show, :destroy]
  resources :guides, only: [:show, :edit, :update, :index, :destroy]
  resources :users
  resources :documents, only: [:edit, :update, :destroy]

  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'

  match '/control', to: 'users#index',          via: 'get'
  
end
