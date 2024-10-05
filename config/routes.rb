Rails.application.routes.draw do
  root 'start#home'
  resources :answers, only: [:show]
  resources :types, only: [:show, :index]
  get 'cookies', to: 'cookies#update'
  get '/me' => 'types#me', as: :my
  ApplicationController::PAGES.each do |path|
    get path => "start##{path}", as: path
  end
end
