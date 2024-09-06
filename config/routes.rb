Rails.application.routes.draw do
  root 'start#home'
  resources :answers, only: [:show]
  resources :types, only: [:show, :index]
  get '/me' => 'types#me', as: :my
  get '/cycle' => 'start#cycle', as: :cycle
  get '/words' => 'start#words', as: :word
  get '/phases' => 'start#phases', as: :phase
end
