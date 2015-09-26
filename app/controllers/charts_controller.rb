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
    def twitch_stats
      stats TwitchStat.all.only(:viewers, :timestamp)
    end

    def game_stats(game)
      game = game.gsub('%20', ' ')
      stats Game.where(name: game).pluck(:stats)[0]
    end

    def stats(data)
      StatsCalculator.new data
    end
end
