require "spec_helper"

describe CodeComparesController do
  describe "routing" do

    it "routes to #create" do
      expect(:post => "/code_compares").to route_to("code_compares#create")
    end

    it "routes to #destroy" do
      expect(:delete => "/code_compares/1").to route_to("code_compares#destroy", :id => "1")
    end

  end
end
