class GameStat
  include Mongoid::Document
  field :timestamp, type: DateTime, default: DateTime.now
  field :viewers, type: Integer
  field :channels, type: Integer
  embedded_in :game
end