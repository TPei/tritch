Rails.application.routes.draw do
  resources :articles
  root 'application#home'
  get 'api' => 'twitch#api'
  get 'api/async' => 'twitch#async'
  get 'api/schedule/:hours' => 'twitch#schedule'
  get 'api/endless/:hours' => 'twitch#endless'

  get 'charts/line' => 'charts#line'
  get 'charts/bar' => 'charts#bar'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
