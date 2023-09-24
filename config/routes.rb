Rails.application.routes.draw do
  root 'start#home'
  get '/theory' => "start#theory", as: :theory
  get '/story' => "start#story", as: :story
  get '/realms' => "start#realms", as: :realms
  resources :answers, only: [:show]
  resources :realms, only: [:show]
  resources :behaviors, only: [:index, :show]
  resources :problems, only: [:index, :show]
  resources :types, only: [:index, :show]
end
