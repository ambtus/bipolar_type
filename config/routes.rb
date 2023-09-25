Rails.application.routes.draw do
  root 'start#intro'
  get '/theory' => "start#theory", as: :theory
  get '/story' => "start#story", as: :story
  get '/chart' => "start#chart", as: :chart
  resources :answers, only: [:show]
  resources :realms, only: [:show]
  resources :behaviors, only: [:index, :show]
  resources :problems, only: [:index, :show]
  resources :types, only: [:index, :show]
end
