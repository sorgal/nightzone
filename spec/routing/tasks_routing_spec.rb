require "spec_helper"

describe TasksController do

  let!(:task) {create :task}

  describe "routing" do

    it "routes to #index" do
      expect(:get => "/tasks").to route_to("tasks#index")
    end

    it "routes to #new" do
      expect(:get => "/tasks/new").to route_to("tasks#new")
    end

    it "routes to #show" do
      expect(:get => "/tasks/#{task.id}").to route_to("tasks#show", :id => "#{task.id}")
    end

    it "routes to #edit" do
      expect(:get => "/tasks/#{task.id}/edit").to route_to("tasks#edit", :id => "#{task.id}")
    end

    it "routes to #create" do
      expect(:post => "/tasks").to route_to("tasks#create")
    end

    it "routes to #update" do
      expect(:put => "/tasks/#{task.id}").to route_to("tasks#update", :id => "#{task.id}")
    end

    it "routes to #destroy" do
      expect(:delete => "/tasks/#{task.id}").to route_to("tasks#destroy", :id => "#{task.id}")
    end

  end
end
