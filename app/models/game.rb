class Game < ActiveRecord::Base

  has_one :admin_game, dependent: :destroy
  has_many :user_games, dependent: :destroy

  validate :title, :start_date, :duration, presence: true

end
