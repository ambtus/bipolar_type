# frozen_string_literal: true

Rails.application.routes.draw do
  root 'application#home'
  get '/depression' => 'application#depression'
  get '/insomnia' => 'application#insomnia'
  get '/mania' => 'application#mania'
  resources :natures, only: %i[show]
  resources :types, only: %i[show]
  resources :behaviors, only: %i[show index]
  get '/me' => 'types#me', as: :my
end
