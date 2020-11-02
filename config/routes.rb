Rails.application.routes.draw do
  root 'start#home'
  get '/theory' => "start#theory", as: :theory
  get '/me' => "start#me", as: :me
  get '/sixteen' => "start#sixteen", as: :sixteen
end
