Rails.application.routes.draw do
  root 'application#home'
  get 'cycle', to: 'application#cycle'
  get 'attitudes', to: 'application#attitudes'
  resources :answers, only: [:show]
  resources :attitudes, only: [:show]
  resources :realms, only: [:show, :index]
  resources :types, only: [:show, :index]
  get 'cookies', to: 'cookies#update'
  get '/me' => 'types#me', as: :my
end
