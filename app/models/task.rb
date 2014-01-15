class Task < ActiveRecord::Base
  has_many :task_hints, dependent: :destroy
  has_many :task_codes, dependent: :destroy
  has_many :user_tasks, dependent: :destroy

  validate :task_text, :points, presence: true
end
