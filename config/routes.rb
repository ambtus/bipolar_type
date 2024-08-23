Rails.application.routes.draw do
  root 'start#home'
  resources :answers, only: [:show]
  resources :types, only: [:show, :index]
  get '/me' => 'types#me', as: :my
  resources :realms, only: [:show]
 # get '/subtypes' => 'realms#subtypes', as: :subtypes
  get '/behaviors' => 'start#behaviors', as: :behaviors
  get '/states' => 'start#states', as: :state
  resources :subtypes, only: [:show]
end
