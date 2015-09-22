class TwitchChannelWorker
  include Sidekiq::Worker
  #sidekiq_options :queue => :channels

  def perform(channel)
    twitch = TwitchChannelQuerier.new(channel)
    twitch.parse_data
  end
end
