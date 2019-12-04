Rails.application.routes.draw do
  root to: 'home#index'
  resources :manufacturers
  resources :subsidiaries
  resources :categories
  resources :clients, only: [:index, :show, :new, :create]
  resources :car_models, only: [:index, :show, :new, :create]
end
