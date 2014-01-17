class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :user_games, dependent: :destroy
  has_many :games, through: :user_games
  has_many :code_compares, dependent: :destroy
  has_many :code_compares, dependent: :destroy
  has_many :user_tasks, dependent: :destroy
  has_many :tasks, through: :user_tasks
  has_many :user_hints, dependent: :destroy
  has_many :hints, through: :user_hints

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
