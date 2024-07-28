Rails.application.routes.draw do
  root 'start#home'
  get '/cycle' => 'start#cycle', as: :cycle
  resources :answers, only: [:show]
  resources :types, only: [:index, :show]
  resources :realms, only: [:index, :show]
  get '/me' => 'types#me', as: :my
end
