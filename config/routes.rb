Rails.application.routes.draw do
  root 'application#home'
  get 'api' => 'twitch#api'
end
