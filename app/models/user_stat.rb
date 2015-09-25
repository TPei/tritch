class UserStat
  include Mongoid::Document
  field :views, type: Integer
  field :followers, type: Integer
  field :timestamp, type: DateTime, default: DateTime.now
  field :status, type: String
  field :mature, type: Boolean
  embedded_in :twitch_user
end
