require "spec_helper"

describe AdminGamesController do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin_games").to route_to("admin_games#index")
    end

    it "routes to #new" do
      expect(:get => "/admin_games/new").to route_to("admin_games#new")
    end

    it "routes to #show" do
      expect(:get => "/admin_games/1").to route_to("admin_games#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin_games/1/edit").to route_to("admin_games#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin_games").to route_to("admin_games#create")
    end

    it "routes to #update" do
      expect(:put => "/admin_games/1").to route_to("admin_games#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin_games/1").to route_to("admin_games#destroy", :id => "1")
    end

  end
end
