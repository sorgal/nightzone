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

  def raise_hint
    @hint = self.hints.where(raised: Hint::NOT).order(:queue_number).first
    if @hint
      self.user_tasks.each do |user_task|
        UserHint.create(user_id: user_task.user_id, hint_id: @hint.id)
      end
      @hint.update(raised: Hint::RAISED)
      notice = "Hint was raised with success"
    else
      notice = "All hints are rised early"
    end
    @notice = notice
  end

end
