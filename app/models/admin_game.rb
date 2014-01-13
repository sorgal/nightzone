class AdminGame < ActiveRecord::Base

  belongs_to :admin_user
  belongs_to :game
end
