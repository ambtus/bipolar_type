Rails.application.routes.draw do
  root 'start#home'
  get '/theory' => "start#theory", as: :theory
  get '/story' => "start#story", as: :story
  resources :types, only: [:index, :show]
  resources :answers, only: [:show]
  resources :realms, only: [:show]
  resources :positions, only: [:show]
  resources :subtypes, only: [:index, :show]
end
