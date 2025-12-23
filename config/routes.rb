# frozen_string_literal: true

Rails.application.routes.draw do
  root 'application#home', as: :introduction
  get '/bipolar' => 'application#bipolar'
  get '/symptoms' => 'application#symptoms'
  get '/concepts' => 'application#concepts'
  resources :realms, only: %i[show index]
  resources :actions, only: %i[show index]
  resources :behaviors, only: %i[show index]
  resources :episodes, only: %i[show index]
  resources :subtypes, only: %i[show index]
  resources :moods, only: %i[show index]
  resources :natures, only: %i[show index]
  resources :types, only: %i[show index]
  get '/me' => 'types#me', as: :my
end
