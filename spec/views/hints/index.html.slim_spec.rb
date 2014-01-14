require 'spec_helper'

describe "hints/index" do
  before do
    hint1 = FactoryGirl.create(:hint)
    hint2 = FactoryGirl.create(:hint, :hint_text => "game_hint_text")
    assign(:hints, [
        hint1, hint2
    #stub_model Game, :id => game2.to_param
    ])
  end

  it "renders a list of hints" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
