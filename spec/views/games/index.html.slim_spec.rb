require 'spec_helper'

describe "games/index" do
  before do
    game1 = FactoryGirl.create(:game)
    game2 = FactoryGirl.create(:game, :title => "game_test_title")
    assign(:games, [
        game1, game2
    #stub_model Game, :id => game2.to_param
    ])
  end

  it "renders a list of games" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
