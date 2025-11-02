# frozen_string_literal: true

Rails.application.routes.draw do
  root 'application#home', as: :introduction
  %w[cycle theory].each do |thing|
    get "/#{thing}" => "application##{thing}"
  end
  %w[attitude behavior mood realm subtype].each do |x|
    get "/#{x.pluralize}" => "application##{x}"
  end
  resources :realms, only: %i[show index]
  resources :attitudes, only: %i[show index]
  resources :behaviors, only: %i[show index]
  resources :episodes, only: %i[show index]
  resources :subtypes, only: %i[show index]
  resources :moods, only: %i[show index]
  resources :types, only: %i[show index]
  get '/me' => 'types#me', as: :my
end
