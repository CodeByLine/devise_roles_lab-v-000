Rails.application.routes.draw do

  # devise_for :posts
  devise_for :users
  root to: 'users#index'
  match 'users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user
  # resources :users
  resources :users, only: [:show, :index, :destroy]
  resources :posts
end
