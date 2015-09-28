class ChartsController < ActionController::Base

  def total_daily
    stats.daily_average
    render json: @stats
  end

  def total_hourly
    hourly_averages = twitch_stats.hourly_average
    render json: hourly_averages
  end

  def total_hourly_game
    game = params[:game]
    hourly_averages = game_stats(game).hourly_average
    render json: hourly_averages
  end

  private

    def chart_data
      @chart_data ||= ChartDataPreparer.new
    end

    def stats(data)
      @stats ||= StatsCalculator.new data
    end

    def twitch_stats
      stats chart_data.twitch_stats
    end

    def game_stats(game)
      stats chart_data.game_stats(game)
    end
end
