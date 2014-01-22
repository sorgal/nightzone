require 'spec_helper'

describe CodeComparesController do
  login_user

  let(:valid_attributes) { { "user_id" => "1" } }

  let(:valid_session) { {} }

  let(:task) { create :task }
  let(:code) { create :code }

  let(:game) { create :game }

  let!(:task_code) { create :task_code, task: task, code: code }
  let!(:user_task) { create :user_task, task: task, user: @user }
  let!(:task_game) { create :game_task, game: game, task: task }
  let!(:user_game) { create :user_game, game: game, user: @user, state: UserGame::CURRENT}

  describe "POST create" do
    describe "with valid params" do
      it "creates a new CodeCompare" do
        expect {
          post :create, {try_text:  code.code_string, task: task}, valid_session
        }.to change(CodeCompare, :count).by(1)
      end

      it "creates a new CodeCompare and end the game of current user" do
        post :create, {try_text: code.code_string, task: task}, valid_session
        expect(UserGame.find(user_game.id).state).to eq(-1)
      end

      it "creates a new CodeCompare with code mismatched result" do
        post :create, {try_text: code.code_string + "sefbgdfgbnfg", task: task}, valid_session
        expect(response).to redirect_to(game_path(game))
      end

      it "send valid pass with complete user game" do
        post :create, {try_text: "1234567890", task: task}, valid_session
        expect(UserGame.find(user_game.id).state).to eq(-1)
      end

      describe "code already inderted" do

        let!(:code_compare) {create :code_compare, code: code, user: user}

        it "insert already inserted code" do
          expect {
            post :create, {try_text:  code.code_string, task: task}, valid_session
          }.to change(CodeCompare, :count).by(0)
        end

      end

      describe "change_task" do
        let(:new_task) { create :task, task_text: "sdgbhdrhndrbhzsgfr" }
        let(:new_code) { create :code, code_string: "dfbdfbndfgnhdfgdfh" }

        let!(:new_task_code) { create :task_code, task: new_task, code: new_code }
        let!(:new_user_task) { build :user_task, user: @user, task: new_task }
        let!(:new_task_game) { create :game_task, game: game, task: new_task }

        it "creates a new CodeCompare and change task" do
          post :create, {try_text: code.code_string, task: task}, valid_session
          expect(UserTask.last.task_id).to eq(new_task.id)
        end

        it "check pass matched and change task" do
          post :create, {try_text: "1234567890", task: task}, valid_session
          expect(UserTask.last.task_id).to eq(new_task.id)
        end
      end

    end
  end

  describe "DELETE destroy" do
    let!(:code_compare) {create :code_compare, code: code, user: @user}
    it "destroys the requested code_compare" do
      expect {
        delete :destroy, {id: code_compare.id}, valid_session
      }.to change(CodeCompare, :count).by(-1)
    end
  end

end