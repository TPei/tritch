require 'moving_average'
require 'contracts'

class StatsCalculator
  include Contracts
  attr_reader :data

  # this code is super bad and super slow

  def initialize(data)
    @data = data
  end

  def hourly_average
    # this works on the premise that we got exactly 12 data points per hour
    # but this is not the case because we can't guarantee that the workers
    # go 24/7 without problems.
    # server downtime / internet disc, strange behaviours where 10 workers won't run
    # and then suddenly 10 run at the same time
    # we gotta use the timestamps here
    average_viewers_per_x_hours 1
  end

  def daily_average
    # TODO implement
  end

  private

    Contract None => ArrayOf[Num]
    def viewers
      data.each.collect{ |date| date['viewers'] }
    end

    def timestamps
      data.each.collect { |date| date['timestamp'] }
    end

    Contract Num => {"viewers" => ArrayOf[Num], "timestamps" => ArrayOf[String]} 
    def average_viewers_per_x_hours(hours)
      accuracy = 12*hours
      simple_moving_average(viewers, timestamps, accuracy)
    end

    Contract ArrayOf[Num], ArrayOf[Time], Num => {"viewers" => ArrayOf[Num], "timestamps" => ArrayOf[String]}
    def simple_moving_average(viewers, timestamps, accuracy)
      stats = {"viewers" => [], "timestamps" => []} 

      (1..viewers.length-1).step(accuracy).each do |i|
        stats["viewers"].push(viewers.exponential_moving_average(i, [i, accuracy].min).to_i)
        stats["timestamps"].push(timestamps[i].strftime("%b %-d, %H:00"))
      end

      return stats
    end
end
