Rails.application.routes.draw do
  root 'type#show'
  get 'type/:id' => 'type#show', as: :type
  get 'theory/:id' => 'theory#show', as: :theory
  get 'discover/:id' => 'discover#show', as: :discover
end
