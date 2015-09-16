Rails.application.routes.draw do
  resources :articles
  root 'application#home'
  get 'charts' => 'application#charts'

  get 'charts/total/daily' => 'charts#total_daily'
  get 'charts/total/hourly' => 'charts#total_hourly'

  get 'api' => 'twitch#api'
  get 'api/async' => 'twitch#async'
  get 'api/schedule/:hours' => 'twitch#schedule'
  get 'api/endless/:hours' => 'twitch#endless'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
