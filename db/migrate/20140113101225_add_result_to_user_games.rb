class AddResultToUserGames < ActiveRecord::Migration
  def change
    add_column :user_games, :result, :integer
  end
end
