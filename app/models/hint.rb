class Hint < ActiveRecord::Base
  has_one :task_hint, dependent: :destroy
  has_many :user_hints, dependent: :destroy
  validate :hint_text, :queue_number, presence: true

  RAISED = 1
  NOT = 0

end
