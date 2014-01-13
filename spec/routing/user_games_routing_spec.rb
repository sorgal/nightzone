require "spec_helper"

describe UserGamesController do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/user_games").to route_to("user_games#index")
    end

    it "routes to #new" do
      expect(:get => "/user_games/new").to route_to("user_games#new")
    end

    it "routes to #show" do
      expect(:get => "/user_games/1").to route_to("user_games#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/user_games/1/edit").to route_to("user_games#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/user_games").to route_to("user_games#create")
    end

    it "routes to #update" do
      expect(:put => "/user_games/1").to route_to("user_games#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/user_games/1").to route_to("user_games#destroy", :id => "1")
    end

  end
end
