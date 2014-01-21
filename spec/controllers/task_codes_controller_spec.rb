require 'spec_helper'

describe TaskCodesController do
  login_admin

  let(:valid_attributes) { { "task_id" => "1" } }

  let(:valid_session) { {} }

  let(:task) {create :task}

  let(:code) {create :code}

  let!(:task_code) {create :task_code, task: task, code: code}

   describe "POST create" do
    describe "with valid params" do
      it "creates a new TaskCode" do
        expect {
          post :create, {:task_code => task_code.attributes}, valid_session
        }.to change(TaskCode, :count).by(1)
      end
    end
   end

  describe "DELETE destroy" do
    it "destroys the requested task_code" do
      expect {
        delete :destroy, {id: task_code.id}, valid_session
      }.to change(TaskCode, :count).by(-1)
    end
  end

end
