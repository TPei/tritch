include ActiveModel::Serialization

class TwitchApiQuerier
  attr_reader :url, :channels

  def initialize(url)
    @url = url
  end

  def parse_data
    @channels = Array.new
    json_data['top'].each do |channel|
      @channels.push(
          {
              name: channel['game']['name'],
              id: channel['game']['id'],
              viewers: channel['viewers']
          }
      )
    end
  end

  private

    def json_data
      JSON.load(open(url))
    end

end