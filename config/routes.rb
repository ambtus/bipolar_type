Rails.application.routes.draw do
  root 'application#home'
  get 'cycle', to: 'application#cycle'
  get 'serenity', to: 'application#serenity'
  get 'things', to: 'application#things'
  resources :answers, only: [:show]
  resources :types, only: [:show, :index]
  resources :subtypes, only: [:show]
  get 'cookies', to: 'cookies#update'
  get '/me' => 'types#me', as: :my
end
