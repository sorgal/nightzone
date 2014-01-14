class AddResultToGames < ActiveRecord::Migration
  def change
    add_column :games, :result, :text
  end
end
