class CreateCodeCompares < ActiveRecord::Migration
  def change
    create_table :code_compares do |t|
      t.integer :user_id
      t.integer :code_id

      t.timestamps
    end
  end
end
