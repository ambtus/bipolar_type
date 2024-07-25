Rails.application.routes.draw do
  root 'start#home'
  get '/cycle' => 'start#cycle', as: :cycle
  get '/realms' => 'start#realms', as: :realms
  get '/balance' => 'start#balance', as: :balance
  resources :answers, only: [:show]
  resources :types, only: [:index, :show]
  get '/me' => 'types#me', as: :my
end
