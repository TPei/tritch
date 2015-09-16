Rails.application.routes.draw do
  resources :articles
  root 'application#home'
  get 'charts' => 'application#charts'

  get 'charts/totalovertime' => 'charts#twitchTotalOverTime'

  get 'api' => 'twitch#api'
  get 'api/async' => 'twitch#async'
  get 'api/schedule/:hours' => 'twitch#schedule'
  get 'api/endless/:hours' => 'twitch#endless'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
