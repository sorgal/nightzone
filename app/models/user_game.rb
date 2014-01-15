class UserGame < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  validate :user_id, :game_id, :result, presence: true
end
