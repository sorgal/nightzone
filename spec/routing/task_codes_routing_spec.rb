require "spec_helper"

describe TaskCodesController do
  describe "routing" do

    it "routes to #create" do
      expect(:post => "/task_codes").to route_to("task_codes#create")
    end

    it "routes to #destroy" do
      expect(:delete => "/task_codes/1").to route_to("task_codes#destroy", :id => "1")
    end

  end
end
