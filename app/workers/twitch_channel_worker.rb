class TwitchChannelWorker
  include Sidekiq::Worker

  def perform(channel)
    twitch = TwitchUsersQuerier.new(channel)
    twitch.parse_data
  end
end
