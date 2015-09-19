class StreamStatsWrapper
  include Mongoid::Document
  belongs_to :stream
  embeds_many :stream_stats
end
