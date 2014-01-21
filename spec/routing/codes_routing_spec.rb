require "spec_helper"

describe CodesController do
  let!(:code) {create :code}
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/codes").to route_to("codes#index")
    end

    it "routes to #new" do
      expect(:get => "/codes/new").to route_to("codes#new")
    end

    it "routes to #show" do
      expect(:get => "/codes/#{code.id}").to route_to("codes#show", :id => "#{code.id}")
    end

    it "routes to #edit" do
      expect(:get => "/codes/#{code.id}/edit").to route_to("codes#edit", :id => "#{code.id}")
    end

    it "routes to #create" do
      expect(:post => "/codes").to route_to("codes#create")
    end

    it "routes to #update" do
      expect(:put => "/codes/#{code.id}").to route_to("codes#update", :id => "#{code.id}")
    end

    it "routes to #destroy" do
      expect(:delete => "/codes/#{code.id}").to route_to("codes#destroy", :id => "#{code.id}")
    end

  end
end
