require "spec_helper"

describe UserHintsController do
  describe "routing" do

    it "routes to #create" do
      expect(:post => "/user_hints").to route_to("user_hints#create")
    end

    it "routes to #destroy" do
      expect(:delete => "/user_hints/1").to route_to("user_hints#destroy", :id => "1")
    end

  end
end
