class TwitchChannelWorker
  include Sidekiq::Worker
  sidekiq_options :queue => :user_stats, :retry => 3

  def perform(channel)
    twitch = TwitchChannelQuerier.new(channel)
    twitch.parse_data
  end
end
