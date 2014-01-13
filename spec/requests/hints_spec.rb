require 'spec_helper'

describe "Hints" do
  describe "GET /hints" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get hints_path
      expect(response.status).to be(200)
    end
  end
end
