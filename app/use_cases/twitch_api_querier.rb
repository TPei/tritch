require 'contracts'

class TwitchApiQuerier
  include Contracts

  Contract None => nil
  def parse_data
    now = DateTime.now

    json_data['top'].each do |top|
      game = Game.find_or_create_by(name: top['game']['name'], game_id: top['game']['_id'])
      GameStat.create(viewers: top['viewers'], channels: top['channels'], game: game, timestamp: now)
    end

    TwitchStat.create(viewers: total_viewers, channels: total_channels, games: json_data['_total'], timestamp: now)

    return
  end

  private

    def url
      api_url = 'https://api.twitch.tv/kraken'
      featured = '/games/top'
      client_id = 'not-this-one'
      url = api_url + featured + '?limit=100&client-id=' + client_id
    end

    def json_data
      @json_data ||= JSON.load(open(url))
    end

    def total_viewers
      json_data['top'].collect{|top| top['viewers']}.sum
    end

    def total_channels
      json_data['top'].collect{ |top| top['channels'] }.sum
    end


end
