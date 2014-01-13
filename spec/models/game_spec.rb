require 'spec_helper'

describe Game do
  it "games validation checking" do
    game_1 = FactoryGirl.create(:game)

    game_1.should be_valid
  end
end
