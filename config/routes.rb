Rails.application.routes.draw do
  root 'start#index'
  resources :start, only: [:index, :show]
  resources :answers, only: [:show]
  resources :realms, only: [:show]
  resources :attitudes, only: [:show]
  resources :subtypes, only: [:index, :show]
  resources :types, only: [:index, :show]
end
