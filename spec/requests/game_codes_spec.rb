require 'spec_helper'

describe "GameCodes" do
  describe "GET /game_codes" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get game_codes_path
      expect(response.status).to be(200)
    end
  end
end
