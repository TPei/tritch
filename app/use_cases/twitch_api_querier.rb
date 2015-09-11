include ActiveModel::Serialization

class TwitchApiQuerier

  def parse_data
    timestamp = Time.now

    json_data['top'].each do |top|
      game = Game.find_or_create_by(name: top['game']['name'], game_id: top['game']['_id'])
      stat = GameStat.create(viewers: top['viewers'], channels: top['channels'], game: game)
    end

    twitch_stat = TwitchStat.create(viewers: total_viewers, channels: total_channels, games: json_data['_total'])
  end

  private

    def url
      api_url = 'https://api.twitch.tv/kraken'
      featured = '/games/top'
      client_id = 'not-this-one'
      url = api_url + featured + '?limit=100&client-id=' + client_id
    end

    def json_data
      json_data ||= JSON.load(open(url))
    end

    def total_viewers
      total_viewers = []
      json_data['top'].each do |top|
        total_viewers.push(top['viewers'])
      end

      total_viewers.sum
    end

    def total_channels
      total_channels = []
      json_data['top'].each do |top|
        total_channels.push(top['channels'])
      end

      total_channels.sum
    end


end