require 'spec_helper'

describe "hints/new" do
  before(:each) do
    assign(:hint, stub_model(Hint).as_new_record)
  end

  it "renders new hint form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", hints_path, "post" do
    end
  end
end
