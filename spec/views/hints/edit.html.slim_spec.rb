require 'spec_helper'

describe "hints/edit" do
  before(:each) do
    @hint = assign(:hint, stub_model(Hint))
  end

  it "renders the edit hint form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", hint_path(@hint), "post" do
    end
  end
end
