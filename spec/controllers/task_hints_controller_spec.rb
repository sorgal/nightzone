require 'spec_helper'

describe TaskHintsController do
  login_admin

  let(:valid_attributes) { { "task_id" => "1" } }
  let(:valid_session) { {} }

  let(:task) {create :task}

  let(:hint) {create :hint}

  let!(:task_hint) {create :task_hint, task: task, hint: hint}

  describe "POST create" do
    describe "with valid params" do
      it "creates a new TaskHint" do
        expect {
          post :create, {task_hint: task_hint.attributes}, valid_session
        }.to change(TaskHint, :count).by(1)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested task_hint" do
      expect {
        delete :destroy, {id: task_hint.id}, valid_session
      }.to change(TaskHint, :count).by(-1)
    end
  end

end
