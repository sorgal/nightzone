require "spec_helper"

describe AdminGamesController do
  let(:admin) {create :admin_user, email: "admin#{rand(1000)}@example.com"}
  let(:game) {create :game}
  let!(:admin_game) {create :admin_game, admin_user: admin, game: game}
  describe "routing" do
   it "routes to #create" do
      expect(:post => "/admin_games").to route_to("admin_games#create")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin_games/#{admin_game.id}").to route_to("admin_games#destroy", :id => "#{admin_game.id}")
    end

  end
end
