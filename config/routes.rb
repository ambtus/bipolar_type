Rails.application.routes.draw do
  root 'start#intro'
  get '/theory' => "start#theory", as: :theory
  get '/mbti' => "start#mbti", as: :mbti
  get '/hours/(:id)' => "start#hours", as: :hours
  get '/months/(:id)' => "start#months", as: :months
  resources :answers, only: [:show]
  resources :realms, only: [:show]
  resources :behaviors, only: [:show, :index]
  resources :types, only: [:show]
end
