require 'spec_helper'

describe "user_games/edit" do
  before(:each) do
    @user_game = assign(:user_game, stub_model(UserGame,
      :user_id => 1,
      :game_id => 1
    ))
  end

  it "renders the edit user_game form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", user_game_path(@user_game), "post" do
      assert_select "input#user_game_user_id[name=?]", "user_game[user_id]"
      assert_select "input#user_game_game_id[name=?]", "user_game[game_id]"
    end
  end
end
