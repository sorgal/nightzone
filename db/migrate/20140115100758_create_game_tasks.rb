class CreateGameTasks < ActiveRecord::Migration
  def change
    create_table :game_tasks do |t|
      t.integer :game_id
      t.integer :task_id

      t.timestamps
    end
  end
end
