Rails.application.routes.draw do
  root 'start#home'
  get '/theory' => "start#theory", as: :theory
  get '/story' => "start#story", as: :story
  resources :answers, only: [:show]
  resources :energies, only: [:index, :show]
  resources :states, only: [:index, :show]
  resources :subtypes, only: [:index, :show]
  resources :types, only: [:show]
end
