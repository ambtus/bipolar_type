Rails.application.routes.draw do
  root 'application#home'
  get 'imbalances', to: 'application#imbalances'
  get 'foci', to: 'application#foci'
  get 'states', to: 'application#states'
  get 'behaviors', to: 'application#behaviors'
  get 'solutions', to: 'application#solutions'
  resources :answers, only: [:show]
  resources :types, only: [:show, :index]
  get 'cookies', to: 'cookies#update'
  get '/me' => 'types#me', as: :my
end
