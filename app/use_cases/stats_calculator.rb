require 'moving_average'

class StatsCalculator
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
       # TODO: should use .only() instead of pluck to get a hash instead of a 2d array
      data ||= TwitchStat.all.pluck(:viewers, :timestamp)
    end

    def viewers
      data.collect(&:first)
    end

    def average_viewers_per_x_hours(hours)
      simple_moving_average(viewers, 12*hours)
    end

    def simple_moving_average(the_stats, accuracy)
      stats = []

      (1..the_stats.length-1).each do |i|
        stats.push(the_stats.exponential_moving_average(i, [i, accuracy].min).to_i)
      end

      return stats
    end
end
