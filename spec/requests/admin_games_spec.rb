require 'spec_helper'

describe "AdminGames" do
  describe "GET /admin_games" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get admin_games_path
      expect(response.status).to be(200)
    end
  end
end
