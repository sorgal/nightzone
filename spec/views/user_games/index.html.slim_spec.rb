require 'spec_helper'

describe "user_games/index" do
  before(:each) do
    game1 = FactoryGirl.create(:game)
    game2 = FactoryGirl.create(:game, title: "dsgsdfgsdfgv")
    assign(:games, [
        game1, game2
    ])
  end

  it "renders a list of user_games" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "new_game", :count => 1
    assert_select "tr>td", :text => "new_game", :count => 1
  end
end
