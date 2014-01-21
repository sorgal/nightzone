require "spec_helper"

describe HintsController do
  let!(:hint) {create :hint}
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/hints").to route_to("hints#index")
    end

    it "routes to #new" do
      expect(:get => "/hints/new").to route_to("hints#new")
    end

    it "routes to #show" do
      expect(:get => "/hints/#{hint.id}").to route_to("hints#show", :id => "#{hint.id}")
    end

    it "routes to #edit" do
      expect(:get => "/hints/#{hint.id}/edit").to route_to("hints#edit", :id => "#{hint.id}")
    end

    it "routes to #create" do
      expect(:post => "/hints").to route_to("hints#create")
    end

    it "routes to #update" do
      expect(:put => "/hints/#{hint.id}").to route_to("hints#update", :id => "#{hint.id}")
    end

    it "routes to #destroy" do
      expect(:delete => "/hints/#{hint.id}").to route_to("hints#destroy", :id => "#{hint.id}")
    end

  end
end
