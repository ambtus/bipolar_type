Rails.application.routes.draw do
  root 'start#home'
  resources :answers, only: [:show]
  resources :types, only: [:show, :index]
  resources :behaviors, only: [:show, :index]
  get '/me' => 'types#me', as: :my
  get '/responses' => 'start#responses', as: :response
end
