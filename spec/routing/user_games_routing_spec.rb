require "spec_helper"

describe UserGamesController do

  let(:user) {create :user}

  let(:game) {create :game}

  let!(:user_game) {create :user_game, user: user, game: game}

  describe "routing" do

    it "routes to #index" do
      expect(:get => "/user_games").to route_to("user_games#index")
    end

    it "routes to #new" do
      expect(:get => "/user_games/new").to route_to("user_games#new")
    end

    it "routes to #show" do
      expect(:get => "/user_games/#{user_game.id}").to route_to("user_games#show", :id => "#{user_game.id}")
    end

    it "routes to #edit" do
      expect(:get => "/user_games/#{user_game.id}/edit").to route_to("user_games#edit", :id => "#{user_game.id}")
    end

    it "routes to #create" do
      expect(:post => "/user_games").to route_to("user_games#create")
    end

    it "routes to #update" do
      expect(:put => "/user_games/#{user_game.id}").to route_to("user_games#update", :id => "#{user_game.id}")
    end

    it "routes to #destroy" do
      expect(:delete => "/user_games/#{user_game.id}").to route_to("user_games#destroy", :id => "#{user_game.id}")
    end

  end
end
