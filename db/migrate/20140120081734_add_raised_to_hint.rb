class AddRaisedToHint < ActiveRecord::Migration
  def change
    add_column :hints, :raised, :integer, default: 0
  end
end
