require 'spec_helper'

describe UserGame do
  it "user games validation checking" do
    user_game_1 = FactoryGirl.create(:user_game)

    user_game_1.should be_valid
  end
end
