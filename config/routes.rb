Rails.application.routes.draw do
  root 'start#home'
  get '/mbti' => 'start#mbti', as: :mbti
  resources :answers, only: [:show]
  resources :types, only: [:show, :index]
  get '/me' => 'types#me', as: :my
  resources :realms, only: [:show]
  get '/cycle' => 'realms#cycle', as: :cycle
  resources :subtypes, only: [:show]
end
