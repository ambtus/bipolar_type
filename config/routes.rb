Rails.application.routes.draw do
  root 'application#home'
  get 'theory', to: 'application#theory'
  resources :answers, only: [:show]
  resources :realms, only: [:show]
  resources :types, only: [:show]
  resources :words, only: [:index]
  get '/me' => 'types#me', as: :my
end
