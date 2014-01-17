class Task < ActiveRecord::Base
  has_many :task_hints, dependent: :destroy
  has_many :hints, through: :task_hints
  has_many :task_codes, dependent: :destroy
  has_many :codes, through: :task_codes
  has_many :user_tasks, dependent: :destroy
  has_one :game_task, dependent: :destroy
  has_one :game, through: :game_task

  validate :task_text, :points, presence: true

  scope :for_user, -> id {joins(:user_tasks).where(user_tasks: {user_id: id})}

end
