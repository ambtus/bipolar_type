Rails.application.routes.draw do
  root 'application#home'
  get 'foci', to: 'application#foci'
  get 'actions', to: 'application#actions'
  get 'imbalances', to: 'application#imbalances'
  resources :answers, only: [:show]
  resources :types, only: [:show, :index]
  get 'cookies', to: 'cookies#update'
  get '/me' => 'types#me', as: :my
end
