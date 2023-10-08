Rails.application.routes.draw do
  root 'start#theory'
  get '/theory' => "start#theory", as: :theory
  get '/hours/(:id)' => "start#hours", as: :hours
  get '/nurture/(:id)' => "start#nurture", as: :nurture
  resources :answers, only: [:show]
  resources :realms, only: [:show]
  resources :behaviors, only: [:show, :index]
  resources :types, only: [:show]
end
