class TaskHint < ActiveRecord::Base
  belongs_to :task

  belongs_to :hint
end
