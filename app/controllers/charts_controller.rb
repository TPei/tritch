class ChartsController < ActionController::Base
  def line
  end

  def bar
  end

  def twitchtotal
  end

  def twitchTotalOverTime
    stats = StatsParser.new
    render json: { 'test' => 'nothing here' }
  end
end