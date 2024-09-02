Rails.application.routes.draw do
  root 'start#home'
  resources :answers, only: [:show]
  resources :types, only: [:show, :index]
  resources :behaviors, only: [:index]
  get '/me' => 'types#me', as: :my
  get '/cycle' => 'start#cycle', as: :cycle
  get '/states' => 'start#states', as: :state
  get '/words' => 'start#words', as: :word
end
