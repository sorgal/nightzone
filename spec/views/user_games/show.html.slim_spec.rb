require 'spec_helper'

describe "user_games/show" do
  before(:each) do
    @user_game = assign(:user_game, stub_model(UserGame,
      :user_id => 1,
      :game_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
  end
end
