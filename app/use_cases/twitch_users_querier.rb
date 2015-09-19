require 'contracts'

class TwitchUsersQuerier
  include Contracts

  attr_reader :channel

  def initialize(channel)
    @channel = channel
  end

  Contract None => String
  def parse_data
    # TODO: this code is the WORST

    now = DateTime.now
    data = json_data['stream']

    return 'offline' unless data

    stream_id = data['_id']
    game = data['game']
    viewers = data['viewers']
    avg_fps = data['average_fps']

    channel = data['channel']
    channel_id = channel['_id']
    channel_name = channel['name']
    channel_followers = channel['followers']
    channel_views = channel['views']
    channel_status = channel['status']
    channel_mature = channel['mature']

    user = TwitchUser.find_or_create_by(username: channel_name, user_id: channel_id)

    u_stat = user.user_stats.where(views: channel_views, followers: channel_followers,
      status: channel_status, mature: channel_mature)

    if u_stat.blank?
      UserStat.create(views: channel_views, followers: channel_followers,
        timestamp: now, status: channel_status, mature: channel_mature, twitch_user: user)
    end


    stream = user.streams.where(game: game, stream_id: stream_id)
    @stream = stream
    @blank = stream.blank?
    if stream.blank?
      stream = Stream.create(game: game, stream_id: stream_id, twitch_user: user)
    else
      stream = stream.first
    end

    ssw = StreamStatsWrapper.where(stream: stream)
    if ssw.blank?
      ssw = StreamStatsWrapper.create(stream: stream)
    else
      ssw = ssw.first
    end

    StreamStat.create(timestamp: now, viewers: viewers, average_fps: avg_fps, stream_stats_wrapper: ssw)

    return 'success'
  end

  private

  def url
    api_url = 'https://api.twitch.tv/kraken'
    featured = '/streams/'
    client_id = 'not-this-one'
    url = api_url + featured + channel
  end

  def json_data
    json_data ||= JSON.load(open(url))
  end

end
