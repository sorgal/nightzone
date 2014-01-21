require "spec_helper"

describe UserTasksController do

  let(:user) {create :user}

  let(:task) {create :task}

  let!(:user_task) {create :user_task, user: user, task: task}

  describe "routing" do

    it "routes to #create" do
      expect(:post => "/user_tasks").to route_to("user_tasks#create")
    end

    it "routes to #destroy" do
      expect(:delete => "/user_tasks/#{user_task.id}").to route_to("user_tasks#destroy", :id => "#{user_task.id}")
    end

  end
end
