class CreateCodes < ActiveRecord::Migration
  def change
    create_table :codes do |t|
      t.string :code_string
      t.timestamps
    end
  end
end
