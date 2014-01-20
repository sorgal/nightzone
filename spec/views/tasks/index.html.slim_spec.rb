require 'spec_helper'

describe "tasks/index" do
  before do
    task1 = FactoryGirl.create(:task)
    task2 = FactoryGirl.create(:task, :task_text => "fzvbsdfgvsdfgvsfd")
    assign(:tasks, [
        task1, task2
    #stub_model Game, :id => game2.to_param
    ])
  end

  it "renders a list of tasks" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
