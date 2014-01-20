class AddStateToUserGames < ActiveRecord::Migration
  def change
    add_column :user_games, :state, :integer, default: 0
  end
end
