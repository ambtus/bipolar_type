Rails.application.routes.draw do
  root 'start#home'
  resources :answers, only: [:show]
  resources :types, only: [:show, :index]
  get '/me' => 'types#me', as: :my
  get '/cycles' => 'start#cycles', as: :cycle
  get '/balance' => 'start#balance', as: :balance
  get '/episodes' => 'start#episodes', as: :episode
  get '/examples' => 'start#examples', as: :example
end
