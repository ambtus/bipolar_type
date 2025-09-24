# frozen_string_literal: true

Rails.application.routes.draw do
  root 'application#home', as: :introduction
  %w[realms cycle theory behaviors].each do |thing|
    get "/#{thing}" => "application##{thing}"
  end
  get '/answer/:id', to: 'application#answer', as: 'answer'
  resources :questions, only: %i[create index show]
  resources :types, only: %i[show index]
  get '/me' => 'types#me', as: :my
end
