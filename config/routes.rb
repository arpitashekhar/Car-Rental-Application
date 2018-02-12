Rails.application.routes.draw do
  #devise_for :users
  resources :reservations
  resources :cars
  resources :searches
  resources :users
  #devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :user
  get 'home/index'
  get 'car/search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
  post 'reservations/checkout'
  post 'reservations/cancel'
  post 'reservations/return'
  get 'users/registrations/show'
  get '/history', to: 'reservations#history'
end

