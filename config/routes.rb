Rails.application.routes.draw do
  root 'start#home'
  get '/me' => 'types#me', as: :my
  get '/realms' => 'start#realms', as: :realms
  get '/problems' => 'start#problems', as: :problems
  get '/solutions' => 'start#solutions', as: :solutions
  get '/cycle' => 'start#cycle', as: :cycle
  resources :types, only: [:index, :show]
  resources :answers, only: [:show]
  resources :realms, only: [:show]
  resources :problems, only: [:show]
  resources :subtypes, only: [:index, :show]
end
