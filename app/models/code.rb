class Code < ActiveRecord::Base
  has_one :game_code, dependent: :destroy
  validate :code_string, presence: true
end
