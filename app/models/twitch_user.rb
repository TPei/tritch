class TwitchUser
  include Mongoid::Document
  field :username, type: String
  field :user_id, type: Integer
  embeds_many :streams
end
