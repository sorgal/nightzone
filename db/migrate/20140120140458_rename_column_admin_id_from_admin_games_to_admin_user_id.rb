class RenameColumnAdminIdFromAdminGamesToAdminUserId < ActiveRecord::Migration
  def change
    rename_column :admin_games, :admin_id, :admin_user_id
  end
end
