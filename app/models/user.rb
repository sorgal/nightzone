class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :user_games, dependent: :destroy
  has_many :code_compares, dependent: :destroy
  has_many :code_compares, dependent: :destroy
  has_many :user_tasks, dependent: :destroy
  has_many :user_hints, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
