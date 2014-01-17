class UserTask < ActiveRecord::Base
  belongs_to :user
  belongs_to :task

  scope :completed, -> { where('state < 0') }
  scope :incomplete, -> { where('state >= 0') }
  scope :for_user, -> id {where(user_id: id)}
end
