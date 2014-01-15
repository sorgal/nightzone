class Code < ActiveRecord::Base
  has_one :task_code, dependent: :destroy
  has_many :code_compares, dependent: :destroy
  validate :code_string, presence: true
end
