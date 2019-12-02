Rails.application.routes.draw do
  root to: 'home#index'
  resources :manufacturers
  resources :subsidiaries, only: [:index, :show, :new, :create]
  resources :categories, only: [:index, :show, :new, :create]
end
