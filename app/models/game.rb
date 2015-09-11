class Game
  include Mongoid::Document
  field :name, type: String
  field :game_id, type: Integer
  embeds_many :game_stats, store_as: 'stats'
end