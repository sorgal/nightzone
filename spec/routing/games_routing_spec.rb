require "spec_helper"

describe GamesController do

  let!(:game) {create :game}

  describe "routing" do

    it "routes to #index" do
      expect(:get => "/games").to route_to("games#index")
    end

    it "routes to #new" do
      expect(:get => "/games/new").to route_to("games#new")
    end

    it "routes to #show" do
      expect(:get => "/games/#{game.id}").to route_to("games#show", :id => "#{game.id}")
    end

    it "routes to #edit" do
      expect(:get => "/games/#{game.id}/edit").to route_to("games#edit", :id => "#{game.id}")
    end

    it "routes to #create" do
      expect(:post => "/games").to route_to("games#create")
    end

    it "routes to #update" do
      expect(:put => "/games/#{game.id}").to route_to("games#update", :id => "#{game.id}")
    end

    it "routes to #destroy" do
      expect(:delete => "/games/#{game.id}").to route_to("games#destroy", :id => "#{game.id}")
    end

  end
end
