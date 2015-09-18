class StreamStat
  include Mongoid::Document
  field :timestamp, type: DateTime, default: DateTime.now
  field :viewers, type: Integer
  field :online_status, type: Boolean
  embedded_in :twitch_stat
end
