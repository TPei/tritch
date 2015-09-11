class TwitchStat
  include Mongoid::Document
  field :timestamp, type: DateTime, default: DateTime.now
  field :viewers, type: Integer
  field :channels, type: Integer
  field :games, type: Integer
end