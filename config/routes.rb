Rails.application.routes.draw do
  root 'application#home'
  get 'things', to: 'application#things'
  get 'actions', to: 'application#actions'
  get 'problems', to: 'application#problems'
  resources :answers, only: [:show]
  resources :types, only: [:show, :index]
  get 'cookies', to: 'cookies#update'
  get '/me' => 'types#me', as: :my
end
