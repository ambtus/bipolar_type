Rails.application.routes.draw do
  root 'start#home'
  get '/theory' => "start#theory", as: :theory
  get '/story' => "start#story", as: :story
  resources :realms, only: [:show]
  resources :natures, only: [:show]
  resources :nurtures, only: [:show]
  resources :problems, only: [:show]
  resources :solutions, only: [:show]
  resources :subtypes, only: [:index, :show]
  resources :behaviors, only: [:index, :show]
  resources :types, only: [:show]
  resources :answers, only: [:show]
end
