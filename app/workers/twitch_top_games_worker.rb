class TwitchTopGamesWorker
  include Sidekiq::Worker
  sidekiq_options :queue => :twitch_stats, :retry => 3 

  def perform
    twitch = TwitchApiQuerier.new
    twitch.parse_data
  end
end
