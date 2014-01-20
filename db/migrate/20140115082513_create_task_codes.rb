class CreateTaskCodes < ActiveRecord::Migration
  def change
    create_table :task_codes do |t|
      t.integer :task_id
      t.integer :code_id

      t.timestamps
    end
  end
end
