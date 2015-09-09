load 'app/use_cases/twitch_api_querier.rb'
require 'open-uri'

class TwitchController < ActionController::Base

  def api
    url = 'https://api.twitch.tv/kraken/games/top?limit=20&client-id=not'
    twitch = TwitchApiQuerier.new(url)
    twitch.parse_data
    render json: twitch
  end
end