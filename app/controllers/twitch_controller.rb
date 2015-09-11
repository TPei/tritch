require './app/workers/twitch_top_games_worker.rb'
require 'open-uri'

class TwitchController < ActionController::Base
  def api
    twitch = TwitchApiQuerier.new
    twitch.parse_data
    render json: {'success' => true}
  end

  def async
    TwitchTopGamesWorker.perform_async
    render json: {'success' => true}
  end
end