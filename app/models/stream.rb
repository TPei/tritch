class Stream
  include Mongoid::Document
  field :game, type: String
  field :stream_id, type: Integer
  has_one :stream_stats_wrapper
  embedded_in :twitch_user
end
