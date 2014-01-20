class CreateUserHints < ActiveRecord::Migration
  def change
    create_table :user_hints do |t|
      t.integer :user_id
      t.integer :hint_id

      t.timestamps
    end
  end
end
