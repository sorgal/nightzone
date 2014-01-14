class CreateCodeCompares < ActiveRecord::Migration
  def change
    create_table :code_compares do |t|
      t.integer :user_id
      t.integer :code_id
      t.integer :result, default: 0

      t.timestamps
    end
  end
end
