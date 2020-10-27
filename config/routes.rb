Rails.application.routes.draw do
  root 'start#home'
  get '/theory' => "start#theory", as: :theory
  get '/me' => "start#me", as: :me
  get '/mom' => "start#mom", as: :mom
end
