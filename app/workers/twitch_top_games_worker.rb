class TwitchTopGamesWorker
  include Sidekiq::Worker

  def perform
    twitch = TwitchApiQuerier.new
    twitch.parse_data
  end
end