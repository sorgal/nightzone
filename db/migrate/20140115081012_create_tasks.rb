class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.text :task_text
      t.integer :points

      t.timestamps
    end
  end
end
