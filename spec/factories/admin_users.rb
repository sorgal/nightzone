# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin_user do
    email "admin@user.com"
    password "0987654321"
  end
end
