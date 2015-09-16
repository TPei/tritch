class ChartsController < ActionController::Base

  def total_daily
    @stats = StatsCalculator.new
    @stats.daily_average
    render json: @stats
  end

  def total_hourly
    @stats = StatsCalculator.new
    @stats.hourly_average
    render json: @stats
  end
end
