class ChartsController < ActionController::Base

  def total_daily
    stats.daily_average
    render json: @stats
  end

  def total_hourly
    stats.hourly_average
    render json: @stats
  end

  private

    def stats
      @stats ||= StatsCalculator.new
    end
end
