require "spec_helper"

describe GameTasksController do

  let(:game) {create :game}

  let(:task) {create :task}

  let!(:game_task) {create :game_task, game: game, task: task}

  describe "routing" do

    it "routes to #create" do
      expect(:post => "/game_tasks").to route_to("game_tasks#create")
    end

    it "routes to #destroy" do
      expect(:delete => "/game_tasks/#{game_task.id}").to route_to("game_tasks#destroy", :id => "#{game_task.id}")
    end

  end
end
