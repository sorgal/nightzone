class UserHint < ActiveRecord::Base
  belongs_to :user
  belongs_to :hint
end
