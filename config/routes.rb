Rails.application.routes.draw do
  root 'start#theory'
  get '/theory' => "start#theory", as: :theory
  get '/hours/(:id)' => "start#hours", as: :hours
  resources :realms, only: [:show]
  resources :behaviors, only: [:show, :index]
  resources :types, only: [:show, :index]
  resources :answers, only: [:show]
end
