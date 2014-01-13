require 'spec_helper'

describe User do

  it "users validation checking" do
    user_1 = FactoryGirl.create(:user, :email=> "user@user.com", :password => "1234567890", password_confirmation: "1234567890")
    user_2 = FactoryGirl.build(:user, :email=> "user@user.com", :password => "1234567890", password_confirmation: "1234567890")
    user_3 = FactoryGirl.build(:user, :email=> "user", :password => "1234567890", password_confirmation: "1234567890")
    user_4 = FactoryGirl.build(:user, :email=> "user@user.com", :password => "1234", password_confirmation: "1234")
    user_5 = FactoryGirl.build(:user, :email=> "user@user.com", :password => "1234567890", password_confirmation: "")
    user_6 = FactoryGirl.build(:user, :email=> "user@user.com", :password => "1234567890", password_confirmation: "1234")
    user_7 = FactoryGirl.build(:user, :email=> "", :password => "", password_confirmation: "")

    user_1.should be_valid
    user_2.should_not be_valid
    user_3.should_not be_valid
    user_4.should_not be_valid
    user_5.should_not be_valid
    user_6.should_not be_valid
    user_7.should_not be_valid
  end

end
