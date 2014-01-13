class GameHint < ActiveRecord::Base
  belongs_to :game
  belongs_to :hint
end
