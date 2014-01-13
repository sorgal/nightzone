class AddQueueNumberToHints < ActiveRecord::Migration
  def change
    add_column :hints, :queue_number, :integer
  end
end
