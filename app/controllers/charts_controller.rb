class ChartsController < ActionController::Base
  def line
  end

  def bar
  end

  def twitchtotal
  end

  def twitchTotalOverTime
    @stats = StatsParser.new
    render json: @stats
  end
end