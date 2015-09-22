class TwitchTopGamesWorker
  include Sidekiq::Worker
  sidekiq_options :queue => :twitch_stats

  def perform
    twitch = TwitchApiQuerier.new
    twitch.parse_data
  end
end
