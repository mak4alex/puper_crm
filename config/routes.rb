Rails.application.routes.draw do
  root 'home#index'
  resources :clients, only: [:index, :show]
  resources :suppliers, only: [:index, :show]
  resources :contacts, only: [:index, :show]
  resources :managers, only: [:index, :show]
  resources :client_deals, only: [:index, :show]
  resources :supplier_deals, only: [:index, :show]
  resources :deals, only: [:new, :create] do
    post 'import', on: :member
    post 'recalc', on: :member
  end
  resources :plans, only: [:new, :create]
  resources :values, only: [:create]
  resources :offers, only: [:index, :create]
end
