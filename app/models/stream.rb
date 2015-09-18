class Stream
  include Mongoid::Document
  field :game, type: String
  field :game_id, type: Integer
  embeds_many :stream_stats, store_as: 'stats'
  embedded_in :twitch_user
end
