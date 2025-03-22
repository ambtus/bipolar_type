Rails.application.routes.draw do
  root 'application#home'
  get 'moods', to: 'application#moods'
  get 'foci', to: 'application#foci'
  get 'aspects', to: 'application#aspects'
  get 'states', to: 'application#states'
  get 'behaviors', to: 'application#behaviors'
  resources :answers, only: [:show]
  resources :types, only: [:show, :index]
  get 'cookies', to: 'cookies#update'
  get '/me' => 'types#me', as: :my
end
