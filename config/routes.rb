# frozen_string_literal: true

Rails.application.routes.draw do
  root 'application#home'
  get '/signals' => 'application#signals'
  get '/cycle' => 'application#cycle'
  resources :types, only: %i[index show]
  resources :concepts, only: %i[index show]
  get '/me' => 'types#me', as: :my
end
