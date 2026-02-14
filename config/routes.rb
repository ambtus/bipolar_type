# frozen_string_literal: true

Rails.application.routes.draw do
  root 'application#home'
  get '/theory' => 'application#theory'
  resources :types, only: %i[index show]
  resources :concepts, only: %i[show]
  get '/me' => 'types#me', as: :my
end
