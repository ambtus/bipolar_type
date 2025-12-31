# frozen_string_literal: true

Rails.application.routes.draw do
  root 'application#home'
  get '/depression' => 'application#depression'
  get '/insomnia' => 'application#insomnia'
  get '/stress' => 'application#stress'
  resources :types, only: %i[show]
  resources :bipolars, only: %i[show]
  resources :behaviors, only: %i[show index]
  get '/me' => 'bipolars#me', as: :my
end
