require "spec_helper"

describe GameCodesController do
  describe "routing" do

    it "routes to #create" do
      expect(:post => "/game_codes").to route_to("game_codes#create")
    end

    it "routes to #destroy" do
      expect(:delete => "/game_codes/1").to route_to("game_codes#destroy", :id => "1")
    end

  end
end
