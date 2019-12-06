Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :manufacturers
  resources :subsidiaries
  resources :categories
  resources :clients
  resources :car_models
  resources :cars
end
