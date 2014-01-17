class UserGame < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  INTACT = 0
  CURRENT = 1
  COMPLETED = -1

  validate :user_id, :game_id, :result, presence: true
  scope :current, -> { where(state: CURRENT) }
end
