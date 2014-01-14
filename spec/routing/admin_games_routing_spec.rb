require "spec_helper"

describe AdminGamesController do
  before do
    @game = FactoryGirl.create(:game)
    @admin_game = FactoryGirl.create(:admin_game, admin_id: 1, game_id: @game.to_param)
  end
  describe "routing" do
   it "routes to #create" do
      expect(:post => "/admin_games").to route_to("admin_games#create")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin_games/#{@admin_game.to_param}").to route_to("admin_games#destroy", :id => "#{@admin_game.to_param}")
    end

  end
end
