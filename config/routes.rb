Rails.application.routes.draw do
  root 'type#show'
  get 'type/:id' => 'type#show', as: :type
  get 'discover/:id' => 'discover#show', as: :discover
  get 'short/:id' => 'short#show', as: :short
end
