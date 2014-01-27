class AddAttachmentDescriptionToTasks < ActiveRecord::Migration
  def self.up
    change_table :tasks do |t|
      t.attachment :description
    end
  end

  def self.down
    drop_attached_file :tasks, :description
  end
end
