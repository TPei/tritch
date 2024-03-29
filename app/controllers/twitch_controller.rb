require './app/workers/twitch_top_games_worker.rb'
require './app/workers/twitch_worker_worker.rb'
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

  def schedule
    hours = params[:hours]
    interval = 5
    repetitions = (hours.to_i * 60 / interval) - 1
    (0..repetitions).each { |mult| TwitchTopGamesWorker.perform_in((interval*mult).minutes) }
    render json: {'success' => true}
  end

  def endless
    hours = params[:hours].to_i
    TwitchWorkerWorker.perform_async(hours)
    render json: {'success' => true}
  end

  def users
    channel = params[:channel]
    tuq = TwitchChannelQuerier.new channel
    status = tuq.parse_data
    render json: {'status' => status}
  end

  def async_users
    TwitchChannelWorker.perform_async(params[:channel])
    render json: {'success' => true}
  end

  def endless_users
    hours = params[:hours].to_i
    channel = params[:channel]
    TwitchChannelWorkerWorker.perform_async(hours, channel)
    render json: {'success' => true}
  end
end
