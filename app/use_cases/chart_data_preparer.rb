class ChartDataPreparer
  def initialize
  end

  def twitch_stats
    TwitchStat.all.only(:viewers, :timestamp)
  end

  def game_stats(game)
    game = de_htmlize game
    Game.where(name: /^#{game}$/i).pluck(:stats)[0]
  end

  private

    def de_htmlize(text)
      text.gsub('%20', ' ')
    end
end
