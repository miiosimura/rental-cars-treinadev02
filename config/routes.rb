Rails.application.routes.draw do
  root to: 'home#index'
  resources :manufacturers
  resources :subsidiaries
  resources :categories
  resources :clients, only: [:index, :show, :new, :create]
end
