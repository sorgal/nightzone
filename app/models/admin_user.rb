class AdminUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :admin_games, dependent: :destroy
  has_many :games, through: :admin_games
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable
end
