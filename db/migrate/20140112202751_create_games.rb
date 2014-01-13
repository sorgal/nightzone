class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :title
      t.datetime :start_date
      t.integer :duration

      t.timestamps
    end
  end
end
