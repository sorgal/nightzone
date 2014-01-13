require "spec_helper"

describe HintsController do
  before do
    queue_number = rand(1...2)
    @game = FactoryGirl.create(:game)
    @hint = FactoryGirl.create(:hint, queue_number: queue_number)
    @invalid_attributes = FactoryGirl.build(:hint, hint_text: "").attributes
  end
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/hints").to route_to("hints#index")
    end

    it "routes to #new" do
      expect(:get => "/hints/new").to route_to("hints#new")
    end

    it "routes to #show" do
      expect(:get => "/hints/1").to route_to("hints#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/hints/1/edit").to route_to("hints#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/hints").to route_to("hints#create")
    end

    it "routes to #update" do
      expect(:put => "/hints/1").to route_to("hints#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/hints/1").to route_to("hints#destroy", :id => "1")
    end

  end
end
