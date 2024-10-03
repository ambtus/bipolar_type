Rails.application.routes.draw do
  root 'start#home'
  resources :answers, only: [:show]
  resources :types, only: [:show, :index]
  get '/me' => 'types#me', as: :my
  get '/cookies', to: 'start#cookies'
  ApplicationController::PAGES.each do |path|
    get path => "start##{path}", as: path
  end
end
