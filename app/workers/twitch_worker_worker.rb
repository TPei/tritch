class TwitchWorkerWorker
  include Sidekiq::Worker
  #sidekiq_options :queue => :twitchtop

  def perform(hour)
    interval = 5
    repetitions = (hour * 60 / interval) - 1
    (0..repetitions).each { |mult| TwitchTopGamesWorker.perform_in((interval*mult).minutes) }

    TwitchWorkerWorker.perform_in(hour.hours, hour)
  end
end
