Rails.application.routes.draw do
  resources :articles
  root 'application#home'
  get 'api' => 'twitch#api'
end
