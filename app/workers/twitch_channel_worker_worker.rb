class TwitchChannelWorkerWorker
  include Sidekiq::Worker
  #sidekiq_options :queue => :channels

  def perform(hour, channel)
    interval = 5
    repetitions = (hour * 60 / interval) - 1
    (0..repetitions).each { |mult| TwitchChannelWorker.perform_in((interval*mult).minutes, channel) }

    TwitchChannelWorkerWorker.perform_in(hour.hours, hour, channel)
  end
end
