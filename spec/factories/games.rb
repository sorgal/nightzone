# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :game do
    title "new_game"
    start_date "01.01.2014 00:00:00".to_datetime
  end
end
