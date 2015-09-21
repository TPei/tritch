Rails.application.routes.draw do
  resources :articles
  root 'application#home'

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
