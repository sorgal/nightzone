class CreateGameCodes < ActiveRecord::Migration
  def change
    create_table :game_codes do |t|
      t.integer :game_id
      t.integer :code_id

      t.timestamps
    end
  end
end
