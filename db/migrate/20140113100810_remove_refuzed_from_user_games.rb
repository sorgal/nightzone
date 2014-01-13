class RemoveRefuzedFromUserGames < ActiveRecord::Migration
  def change
    remove_column :user_games, :refuzed, :text
  end
end
