# frozen_string_literal: true

Rails.application.routes.draw do
  root 'application#home'
  get '/basic' => 'application#basic'
  get '/morning' => 'application#morning'
  get '/midday' => 'application#midday'
  get '/afternoon' => 'application#afternoon'
  get '/evening' => 'application#evening'
  resources :types, only: %i[show index]
  resources :behaviors, only: %i[show index]
  get '/me' => 'types#me', as: :my
end
