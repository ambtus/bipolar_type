# frozen_string_literal: true

Rails.application.routes.draw do
  root 'application#home', as: :introduction
  get '/realms' => 'application#realms'
  get '/attitudes' => 'application#attitudes'
  resources :types, only: %i[show index]
  resources :words, only: %i[create index]
  get '/me' => 'types#me', as: :my
end
