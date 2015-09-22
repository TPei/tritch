require 'moving_average'
require 'contracts'

class StatsCalculator
  include Contracts

  # this code is super bad and super slow

  def initialize
  end

  def hourly_average
    # this works on the premise that we got exactly 12 data points per hour
    # but this is not the case because we can't guarantee that the workers
    # go 24/7 without problems.
    # server downtime / internet disc, strange behaviours where 10 workers won't run
    # and then suddenly 10 run at the same time
    # we gotta use the timestamps here
    @stats = average_viewers_per_x_hours 1
  end

  def daily_average
    # TODO implement
  end

  private

    def data
      # TODO: exclude this from json serialization
      @data ||= TwitchStat.all.only(:viewers, :timestamp)
    end

    Contract None => ArrayOf[Num]
    def viewers
      data.collect{ |date| date['viewers'] }
    end

    def timestamps
      data.collect { |date| date['timestamp'] }
    end

    #Contract Num => ArrayOf[ArrayOf[Num], ArrayOf[Time]]
    def average_viewers_per_x_hours(hours)
      accuracy = 12*hours
      [simple_moving_average(viewers, accuracy), (accuracy - 1).step(timestamps.size - 1, accuracy).map { |i| timestamps[i].strftime("%b %-d, %H:00") }]
    end

    Contract ArrayOf[Num], Num => ArrayOf[Num]
    def simple_moving_average(the_stats, accuracy)
      stats = []

      (1..the_stats.length-1).step(accuracy).each do |i|
        stats.push(the_stats.exponential_moving_average(i, [i, accuracy].min).to_i)
      end

      return stats
    end
end
