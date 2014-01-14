# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email "user@user.com"
    password "1234567890"
    password_confirmation "1234567890"
  end
end
