# frozen_string_literal: true

Rails.application.routes.draw do
  root 'application#home'
  get '/basic' => 'application#basic'
  Action.each do |action|
    get "/#{action.render}" => "application##{action.render}"
  end
  #get '/theory' => 'application#theory'
  #get '/definitions' => 'application#definitions'
  #get '/behaviors' => 'application#behaviors'
  resources :types, only: %i[show]
  get '/me' => 'types#me', as: :my
end
