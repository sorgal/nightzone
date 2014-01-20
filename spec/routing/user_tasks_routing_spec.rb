require "spec_helper"

describe UserTasksController do
  describe "routing" do

    it "routes to #create" do
      expect(:post => "/user_tasks").to route_to("user_tasks#create")
    end

    it "routes to #destroy" do
      expect(:delete => "/user_tasks/1").to route_to("user_tasks#destroy", :id => "1")
    end

  end
end
