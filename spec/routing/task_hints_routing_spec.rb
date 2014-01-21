require "spec_helper"

describe TaskHintsController do

  let(:task) {create :task}

  let(:hint) {create :hint}

  let!(:task_hint) {create :task_hint, task: task, hint: hint}

  describe "routing" do

    it "routes to #create" do
      expect(:post => "/task_hints").to route_to("task_hints#create")
    end

    it "routes to #destroy" do
      expect(:delete => "/task_hints/#{task_hint.id}").to route_to("task_hints#destroy", :id => "#{task_hint.id}")
    end

  end
end
