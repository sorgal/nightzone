require "spec_helper"

describe CodeComparesController do

  let(:user) {create :user}

  let(:code) {create :code}

  let!(:code_compare) {create :code_compare, user: user, code: code}

  describe "routing" do

    it "routes to #create" do
      expect(:post => "/code_compares").to route_to("code_compares#create")
    end

    it "routes to #destroy" do
      expect(:delete => "/code_compares/#{code_compare.id}").to route_to("code_compares#destroy", :id => "#{code_compare.id}")
    end

  end
end
