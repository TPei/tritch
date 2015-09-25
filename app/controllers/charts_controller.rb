class ChartsController < ActionController::Base

  def total_daily
    stats.daily_average
    render json: @stats
  end

  def total_hourly
    hourly_averages = stats.hourly_average
    render json: hourly_averages
  end

  private

    def stats
      @stats ||= StatsCalculator.new
    end
end
