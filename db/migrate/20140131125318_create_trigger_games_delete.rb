# This migration was auto-generated via `rake db:generate_trigger_migration'.
# While you can edit this file, any changes you make to the definitions here
# will be undone by the next auto-generated trigger migration.

class CreateTriggerGamesDelete < ActiveRecord::Migration
  def up
    create_trigger("games_after_delete_row_tr", :generated => true, :compatibility => 1).
        on("games").
        after(:delete) do
      "DELETE `tasks`.* FROM `tasks` INNER JOIN `game_tasks` ON `game_tasks`.`game_id` = OLD.`id` WHERE `tasks`.`id` = `game_tasks`.`task_id`;"
    end
  end

  def down
    drop_trigger("games_after_delete_row_tr", "games", :generated => true)
  end
end
