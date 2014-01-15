require "spec_helper"

describe TaskHintsController do
  describe "routing" do

    it "routes to #create" do
      expect(:post => "/task_hints").to route_to("task_hints#create")
    end

    it "routes to #destroy" do
      expect(:delete => "/task_hints/1").to route_to("task_hints#destroy", :id => "1")
    end

  end
end
