require 'contracts'

class TwitchUsersQuerier
  include Contracts

  attr_reader :channel

  def initialize(channel)
    @channel = channel
  end

  Contract None => String
  def parse_data
    # TODO: this code is still the WORST

    return 'offline' unless data

    user = TwitchUser.find_or_create_by(username: channel_name, user_id: channel_id)

    user_stat = create_user_stat(user, channel_views, channel_followers, channel_status, channel_mature)

    stream = create_stream(game, stream_id, user)

    stream_stat = create_stream_stat(stream, viewers, average_fps)

    return 'success'
  end

  private

    def create_user_stat(user, views, followers, status, mature)
      u_stat = user.user_stats.where(views: views, followers: followers,
        status: status, mature: mature)

      if u_stat.blank?
        UserStat.create(views: views, followers: followers,
          timestamp: DateTime.now, status: status, mature: mature, twitch_user: user)
      end
    end

    def create_stream(game, stream_id, user)
      stream = user.streams.where(game: game, stream_id: stream_id)
      if stream.blank?
        stream = Stream.create(game: game, stream_id: stream_id, twitch_user: user)
      else
        stream = stream.first
      end

      return stream
    end

    def create_stream_stat(stream, viewers, avg_fps)
      ssw = StreamStatsWrapper.where(stream: stream)
      if ssw.blank?
        ssw = StreamStatsWrapper.create(stream: stream)
      else
        ssw = ssw.first
      end

      StreamStat.create(timestamp: DateTime.now, viewers: viewers, average_fps: avg_fps, stream_stats_wrapper: ssw)
    end

    def url
      api_url = 'https://api.twitch.tv/kraken'
      featured = '/streams/'
      client_id = 'not-this-one'
      url = api_url + featured + channel
    end

    def json_data
      @json_data ||= JSON.load(open(url))
    end

    def data
      @data ||= json_data['stream']
    end

    def stream_id
      @stream_id ||= data['_id']
    end

    def game
      @game ||= data['game']
    end

    def viewers
      @viewers ||= data['viewers']
    end

    def average_fps
      @average_fps ||= data['average_fps']
    end

    def channel
      @channel ||= data['channel']
    end

    def channel_id
      @channel_id ||= channel['_id']
    end

    def channel_name
      @channel_name ||= channel['name']
    end

    def channel_followers
      @channel_followers ||= channel['followers']
    end

    def channel_views
      @channel_views ||= channel['views']
    end

    def channel_status
      @channel_status ||= channel['status']
    end

    def channel_mature
      @channel_mature ||= channel['mature']
    end
end
