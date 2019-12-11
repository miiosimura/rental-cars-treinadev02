Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :manufacturers, only: [:index, :new, :create, :show, :edit, :update]
  resources :subsidiaries
  resources :categories, only: [:index, :new, :create, :show, :edit, :update]
  resources :clients, only: [:index, :new, :create, :show, :edit, :update]
  resources :car_models, only: [:index, :new, :create, :show, :edit, :update]
  resources :cars, only: [:index, :new, :create, :show, :edit, :update]
  resources :rentals, only: [:index, :new, :create, :show, :edit, :update] do
    get 'search', on: :collection #para ter o ID depois
    post 'start', on: :member #member para garantir que tenha um ID antes
  end
end
