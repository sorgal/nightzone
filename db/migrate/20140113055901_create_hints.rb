class CreateHints < ActiveRecord::Migration
  def change
    create_table :hints do |t|
      t.text :hint_text
      t.timestamps
    end
  end
end
