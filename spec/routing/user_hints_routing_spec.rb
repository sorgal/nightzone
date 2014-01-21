require "spec_helper"

describe UserHintsController do

  let(:user) {create :user}

  let(:hint) {create :hint}

  let!(:user_hint) {create :user_hint, user: user, hint: hint}

  describe "routing" do

    it "routes to #create" do
      expect(:post => "/user_hints").to route_to("user_hints#create")
    end

    it "routes to #destroy" do
      expect(:delete => "/user_hints/#{user_hint.id}").to route_to("user_hints#destroy", :id => "#{user_hint.id}")
    end

  end
end
