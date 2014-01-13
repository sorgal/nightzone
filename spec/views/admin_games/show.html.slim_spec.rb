require 'spec_helper'

describe "admin_games/show" do
  before(:each) do
    @admin_game = assign(:admin_game, stub_model(AdminGame,
      :admin_id => 1,
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
