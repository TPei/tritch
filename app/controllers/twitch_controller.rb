load 'app/use_cases/twitch_api_querier.rb'
require 'open-uri'

class TwitchController < ActionController::Base

  def api
    # TODO cleanup
    api_url = 'https://api.twitch.tv/kraken'
    featured = '/streams/featured'
    client_id = 'not-this-one'
    url =  api_url + featured + '?limit=20&client-id=' + client_id

    twitch = TwitchApiQuerier.new(url)
    twitch.parse_data
    render json: twitch
  end
end