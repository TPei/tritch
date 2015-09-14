class StatsParser
  def initialize
    @stats = TwitchStat.all.pluck(:viewers)
  end
end