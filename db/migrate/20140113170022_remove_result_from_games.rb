class RemoveResultFromGames < ActiveRecord::Migration
  def change
    remove_column :games, :result
  end
end
