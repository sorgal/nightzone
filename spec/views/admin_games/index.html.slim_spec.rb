require 'spec_helper'

describe "admin_games/index" do
  before(:each) do
    assign(:admin_games, [
      stub_model(AdminGame,
        :admin_id => 1,
        :game_id => 2
      ),
      stub_model(AdminGame,
        :admin_id => 1,
        :game_id => 2
      )
    ])
  end

  it "renders a list of admin_games" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
