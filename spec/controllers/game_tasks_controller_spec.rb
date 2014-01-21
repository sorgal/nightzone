require 'spec_helper'

describe GameTasksController do
  login_admin

  let(:valid_attributes) { { "game_id" => "1" } }

  let(:valid_session) { {} }

  let(:game) {create :game}

  let(:task) {create :task}

  let!(:game_task) {create :game_task, game: game, task: task}

  describe "POST create" do
    describe "with valid params" do
      it "creates a new GameTask" do
        expect {
          post :create, {game_task: game_task.attributes}, valid_session
        }.to change(GameTask, :count).by(1)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested game_task" do
      expect {
        delete :destroy, {id: game_task.id}, valid_session
      }.to change(GameTask, :count).by(-1)
    end
  end

end
