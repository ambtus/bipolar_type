Rails.application.routes.draw do
  root 'start#home'
  resources :answers, only: [:show]
  resources :types, only: [:show, :index]
  get '/me' => 'types#me', as: :my
  get '/cycle' => 'start#cycle', as: :cycle
  get '/examples' => 'start#examples', as: :example
  get '/behaviors' => 'start#behaviors', as: :behavior
end
