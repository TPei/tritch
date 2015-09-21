class TwitchChannelWorker
  include Sidekiq::Worker

  def perform(channel)
    twitch = TwitchChannelQuerier.new(channel)
    twitch.parse_data
  end
end
