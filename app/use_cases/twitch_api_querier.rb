include ActiveModel::Serialization

class TwitchApiQuerier
  attr_reader :url, :channels

  def initialize(url)
    @url = url
  end

  def parse_data
    @streams = Array.new

    json_data['featured'].each do |feature|
      @streams.push(
          {
              game: feature['stream']['game'],
              id: feature['stream']['_id'],
              viewers: feature['stream']['viewers'],
              stream_link: feature['stream']['_links']['self'],
              channel_id: feature['stream']['channel']['_id'],
              channel_name: feature['stream']['channel']['display_name'],
              channel_link: feature['stream']['channel']['_links']['self'],
              profile_image: feature['stream']['preview']['template'],

          }
      )
    end
  end

  private

    def json_data
      JSON.load(open(url))
    end

end