class TwitchUser
  include Mongoid::Document
  field :username, type: String
  field :user_id, type: Integer
  embeds_many :streams
  embeds_many :user_stats
end
