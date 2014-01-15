class Hint < ActiveRecord::Base
  has_one :task_hint, dependent: :destroy

  validate :hint_text, :queue_number, presence: true
end
