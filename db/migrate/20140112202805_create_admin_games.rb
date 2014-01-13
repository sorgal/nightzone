class CreateAdminGames < ActiveRecord::Migration
  def change
    create_table :admin_games do |t|
      t.integer :admin_id
      t.integer :game_id

      t.timestamps
    end
  end
end
