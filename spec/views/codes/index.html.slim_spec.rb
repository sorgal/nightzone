require 'spec_helper'

describe "codes/index" do
  before do
    code1 = FactoryGirl.create(:code)
    code2 = FactoryGirl.create(:code, :code_string => "game_test_title")
    assign(:codes, [
        code1, code2
    #stub_model Game, :id => game2.to_param
    ])
  end


  it "renders a list of codes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
