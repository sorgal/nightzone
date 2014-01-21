require 'spec_helper'

describe UserTasksController do
  login_user

  let(:valid_attributes) { { "user_id" => "1" } }

  let(:valid_session) { {} }

  let(:task) {create :task}

  let!(:user_task) {create :user_task, user: @user, task: task, result: rand(0...3)}

  describe "POST create" do
    describe "with valid params" do
      it "creates a new UserTask" do
        expect {
          post :create, {user_task: user_task.attributes}, valid_session
        }.to change(UserTask, :count).by(1)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested user_task" do
      expect {
        delete :destroy, {id: user_task.id}, valid_session
      }.to change(UserTask, :count).by(-1)
    end
  end

end
