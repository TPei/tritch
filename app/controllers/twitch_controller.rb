load 'app/use_cases/twitch_api_querier.rb'
require 'open-uri'

class TwitchController < ActionController::Base

  def api
    twitch = TwitchApiQuerier.new
    twitch.parse_data
    render json: {'success' => true}
  end
end