require "spec_helper"

describe GameHintsController do

  before do
    @game = FactoryGirl.create(:game)
    @hint = FactoryGirl.create(:hint)
    @game_hint = FactoryGirl.create(:game_hint, game_id: @game.to_param, hint_id: @hint.to_param)
  end
  describe "routing" do

   it "routes to #create" do
      expect(:post => "/game_hints").to route_to("game_hints#create")
    end

    it "routes to #destroy" do
      expect(:delete => "/game_hints/#{@game_hint.to_param}").to route_to("game_hints#destroy", :id => "#{@game_hint.to_param}")
    end

  end
end
