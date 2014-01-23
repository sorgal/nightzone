class Hint < ActiveRecord::Base
  has_one :task_hint, dependent: :destroy
  has_many :user_hints, dependent: :destroy
  validates :hint_text, :queue_number, presence: true
  #validates :queue_number, inclusion: {in: [1, 2]}

  RAISED = 1
  NOT = 0

end
