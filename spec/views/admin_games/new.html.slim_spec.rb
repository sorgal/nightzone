require 'spec_helper'

describe "admin_games/new" do
  before(:each) do
    assign(:admin_game, stub_model(AdminGame,
      :admin_id => 1,
      :game_id => 1
    ).as_new_record)
  end

  it "renders new admin_game form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", admin_games_path, "post" do
      assert_select "input#admin_game_admin_id[name=?]", "admin_game[admin_id]"
      assert_select "input#admin_game_game_id[name=?]", "admin_game[game_id]"
    end
  end
end
