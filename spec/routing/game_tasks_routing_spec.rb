require "spec_helper"

describe GameTasksController do
  describe "routing" do

    it "routes to #create" do
      expect(:post => "/game_tasks").to route_to("game_tasks#create")
    end

    it "routes to #destroy" do
      expect(:delete => "/game_tasks/1").to route_to("game_tasks#destroy", :id => "1")
    end

  end
end
