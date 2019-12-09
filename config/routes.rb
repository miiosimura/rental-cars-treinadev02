Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :manufacturers
  resources :subsidiaries
  resources :categories
  resources :clients
  resources :car_models
  resources :cars
  resources :rentals, only: [:index, :new, :create, :show] do
    get 'search', on: :collection #mais 2 modelos
    #post 'start', on: :member
  end
end
