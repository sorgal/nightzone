class CreateTaskHints < ActiveRecord::Migration
  def change
    create_table :task_hints do |t|
      t.integer :task_id
      t.integer :hint_id

      t.timestamps
    end
  end
end
