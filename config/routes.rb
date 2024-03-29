Rails.application.routes.draw do
  resources :articles
  root 'application#home'
  get 'charts' => 'application#charts'

  get 'charts/total/daily' => 'charts#total_daily'
  get 'charts/total/hourly' => 'charts#total_hourly'
  get 'charts/total/hourly/:game' => 'charts#total_hourly_game'

  get 'api' => 'twitch#api'
  get 'api/async' => 'twitch#async'
  get 'api/schedule/:hours' => 'twitch#schedule'
  get 'api/endless/:hours' => 'twitch#endless'

  get 'api/users/:channel' => 'twitch#users'
  get 'api/users/async/:channel' => 'twitch#async_users'
  get 'api/users/endless/:hours/:channel' => 'twitch#endless_users'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
