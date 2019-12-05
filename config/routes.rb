Rails.application.routes.draw do
  root to: 'home#index'
  resources :manufacturers
  resources :subsidiaries
  resources :categories
  resources :clients
  resources :car_models
  resources :cars
end
