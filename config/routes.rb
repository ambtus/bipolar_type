Rails.application.routes.draw do
  root 'application#home'
  get 'moods', to: 'application#moods'
  get 'foci', to: 'application#foci'
  get 'actions', to: 'application#actions'
  get 'states', to: 'application#states'
  get 'behaviors', to: 'application#behaviors'
  get 'problems', to: 'application#problems'
  resources :answers, only: [:show]
  resources :types, only: [:show, :index]
  get 'cookies', to: 'cookies#update'
  get '/me' => 'types#me', as: :my
end
