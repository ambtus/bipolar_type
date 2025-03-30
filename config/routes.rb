Rails.application.routes.draw do
  root 'application#home'
  get 'cycle', to: 'application#cycle'
  get 'attitudes', to: 'application#attitudes'
  get 'realms', to: 'application#realms'
  resources :answers, only: [:show]
  resources :types, only: [:show, :index]
  get 'cookies', to: 'cookies#update'
  get '/me' => 'types#me', as: :my
end
