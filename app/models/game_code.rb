class GameCode < ActiveRecord::Base
  belongs_to :game
  belongs_to :code
end
