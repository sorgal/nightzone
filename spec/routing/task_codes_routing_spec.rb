require "spec_helper"

describe TaskCodesController do

  let(:task) {create :task}

  let(:code) {create :code}

  let!(:task_code) {create :task_code, task: task, code: code}

  describe "routing" do

    it "routes to #create" do
      expect(:post => "/task_codes").to route_to("task_codes#create")
    end

    it "routes to #destroy" do
      expect(:delete => "/task_codes/#{task_code.id}").to route_to("task_codes#destroy", :id => "#{task_code.id}")
    end

  end
end
