Rails.application.routes.draw do
  root 'home#index'
  resources :clients, only: [:index, :show]
  resources :suppliers, only: [:index, :show]
  resources :contacts, only: [:index, :show]
  resources :managers, only: [:index, :show]
  resources :client_deals, only: [:index, :show]
  resources :supplier_deals, only: [:index, :show]
  resources :deals, only: [:new, :create]
  resources :offers, only: [] do
    collection do
      get 'new_for_client'
      get 'new_for_supplier'
      post 'create_for_client'
      post 'create_for_supplier'
    end
  end
end
