Rails.application.routes.draw do
  root 'application#home'
  get 'moods', to: 'application#moods'
  get 'foci', to: 'application#foci'
  get 'shoulds', to: 'application#shoulds'
  get 'phases', to: 'application#phases'
  get 'behaviors', to: 'application#behaviors'
  get 'problems', to: 'application#problems'
  resources :answers, only: [:show]
  resources :types, only: [:show, :index]
  get 'cookies', to: 'cookies#update'
  get '/me' => 'types#me', as: :my
end
