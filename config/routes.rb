Rails.application.routes.draw do
  root 'application#home', as: :introduction
  get 'theory', to: 'application#theory', as: :theory
  resources :answers, only: [:show]
  resources :realms, only: [:show]
  resources :attitudes, only: [:show]
  resources :types, only: %i[show index]
  get 'types', to: 'types#index', as: :bipolar_types
  resources :words, only: [:index]
  get '/me' => 'types#me', as: :my
end
