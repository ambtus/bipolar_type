Rails.application.routes.draw do
  root 'start#index'
  get '/theory' => "start#show", as: :theory
  resources :answers, only: [:show]
  resources :realms, only: [:index, :show]
  resources :attitudes, only: [:index, :show]
  resources :subtypes, only: [:index, :show]
  resources :types, only: [:show]
end
