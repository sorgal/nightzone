class CreateGameHints < ActiveRecord::Migration
  def change
    create_table :game_hints do |t|
      t.integer :game_id
      t.integer :hint_id

      t.timestamps
    end
  end
end
