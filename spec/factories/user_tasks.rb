# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_task do
    user_id 1
    task_id 1
    result -1
  end
end
