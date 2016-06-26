Rails.application.routes.draw do
  root 'start#index'
  resources :answers, only: [:show]
  resources :realms, only: [:index, :show]
  resources :natures, only: [:index, :show]
  resources :subtypes, only: [:show]
  resources :types, only: [:index, :show]
end
