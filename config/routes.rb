Rails.application.routes.draw do
  root 'application#home'
  get 'problems', to: 'application#problems'
  get 'realms', to: 'application#realms'
  get 'cycle', to: 'application#cycle'
  resources :answers, only: [:show]
  resources :types, only: [:show, :index]
  get 'cookies', to: 'cookies#update'
  get '/me' => 'types#me', as: :my
end
