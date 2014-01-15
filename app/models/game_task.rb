class GameTask < ActiveRecord::Base
  belongs_to :game
  belongs_to :task
end
