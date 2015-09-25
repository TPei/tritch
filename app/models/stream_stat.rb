class StreamStat
  include Mongoid::Document
  field :timestamp, type: DateTime, default: DateTime.now
  field :viewers, type: Integer
  field :average_fps, type: Float
  embedded_in :stream_stats_wrapper
end
