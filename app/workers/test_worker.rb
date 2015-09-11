class TestWorker
  include Sidekiq::Worker

  def perform(viewers, channels, games)
    TwitchStat.create(viewers: viewers, channels: channels, games: games)
  end
end
