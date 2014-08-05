Rails.application.routes.draw do
  root 'pages#home'
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  match '/signup',  to: 'users#new',            via: 'get'
end
