require 'spec_helper'

describe "hints/show" do
  before(:each) do
    @hint = assign(:hint, stub_model(Hint))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
