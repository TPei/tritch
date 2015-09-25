class TwitchTopGamesWorker
  include Sidekiq::Worker
  #sidekiq_options :queue => :twitchtop

  def perform
    twitch = TwitchApiQuerier.new
    twitch.parse_data
  end
end
