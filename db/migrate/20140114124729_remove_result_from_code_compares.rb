class RemoveResultFromCodeCompares < ActiveRecord::Migration
  def change
    remove_column :code_compares, :result
  end
end
