class ChartsController < ActionController::Base

  def twitchTotalOverTime
    @stats = StatsParser.new
    @stats.hourly_average
    render json: @stats
  end
end
