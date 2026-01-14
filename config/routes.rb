# frozen_string_literal: true

Rails.application.routes.draw do
  root 'application#home'
  get '/theory' => 'application#theory'
  Mood.each do |mood|
    get "/#{mood.string}" => "application##{mood.string}"
  end
  get '/bp' => 'application#bp'
  get '/definitions' => 'application#definitions'
  resources :types, only: %i[show]
  get '/me' => 'types#me', as: :my
end
