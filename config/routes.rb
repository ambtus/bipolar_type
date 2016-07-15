Rails.application.routes.draw do
  root 'start#index'
  resources :start, only: [:index, :show]
  resources :answers, only: [:show]
  resources :realms, only: [:index, :show]
  resources :attitudes, only: [:index, :show]
  resources :subtypes, only: [:index, :show]
  resources :types, only: [:index, :show]
end
