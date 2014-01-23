require 'spec_helper'

describe Game do

  let(:user) {create :user}

  let(:game) {create :game}

  let(:code) {create :code}

  let(:task) {create :task}

  let!(:user_task) {create :user_task, user: user, task: task, result: 3}

  let!(:task_code) {create :task_code, task: task, code: code}

  let!(:task_game) {create :game_task, game: game, task: task}

  let!(:user_game) {create :user_game, user: user, game: game, state: 1}

  it "games validation checking" do
    game.should be_valid
  end

  describe "create code compare testing" do

    it "code compare processing" do
      count = CodeCompare.count
      expect(game.process(user, task, code.code_string) == "Code was matched. Game completed")
      expect(CodeCompare.count).to eq(count + 1)
    end

     it "creates a new CodeCompare and end the game of current user" do
      expect(game.process(user, task, code.code_string) == "Code was matched. Game completed")
      expect(UserGame.find(user_game.id).state).to eq(-1)
    end

    it "creates a new CodeCompare with code mismatched result" do
      expect(game.process(user, task, code.code_string + "egbrhnjtyhjnawfgbh") == "Code or pass was not matched")
      expect(UserTask.last.task_id).to eq(task.id)
      expect(UserGame.find(user_game.id).state).to eq(1)
    end

    it "send valid pass with complete of user game" do
      expect(game.process(user, task, "1234567890") == "Code was matched. Game completed")
      expect(UserGame.find(user_game.id).state).to eq(-1)
    end

    describe "code already inderted" do

      let!(:code_compare) {create :code_compare, code: code, user: user}

      it "insert already inserted code" do
        count = CodeCompare.count
        expect(game.process(user, task, code.code_string) == "Compare for this code created early")
        expect(CodeCompare.count).to equal(count)
      end

    end

    describe "more then one code" do

      let!(:new_code) {create :code, code_string: "dfbdfbndfgnhdfgdfh"}

      describe "with second code" do

        let!(:second_task_code) {create :task_code, task: task, code: new_code}

        it "creates code compare without ending game or changing task" do
          count = CodeCompare.count
          expect(game.process(user, task, code.code_string) == "Code was matched")
          expect(CodeCompare.count).to equal(count + 1)
        end

      end

      describe "assign next task" do
        let!(:new_task) {create :task, task_text: "sdgbhdrhndrbhzsgfr"}
        let(:new_user_task) {build :user_task, user: user, task: new_task}
        let!(:new_task_code) {create :task_code, task: new_task, code: new_code}
        let!(:new_task_game) {create :game_task, game: game, task: new_task}

        it "creates a new CodeCompare and change task" do
          expect(game.process(user, task, "1234567890") == "Code was matched. Next task assigned")
          expect(UserTask.last.task_id).to eq(new_task.id)
        end
        it "code compare processing and change task" do
          expect(game.process(user, task, code.code_string) == "Code was matched. Next task assigned")
          expect(UserTask.last.task_id).to eq(new_task.id)
        end
      end

    end
  end
  describe "Start and finish game" do
    describe "Start game" do
       it "execute action " do
        expect {
          game.start_game
        }.to change(UserTask, :count).by(1)
      end

      it "check game state equal to CURRENT" do
        game.start_game
        expect(Game.find(game.id).state).to equal(UserGame::CURRENT)
      end

      it "check user_game state equal to CURRENT" do
        game.start_game
        expect(UserGame.where(user_id: user.id, game_id: game.id).first.state).to equal(UserGame::CURRENT)
      end

    end

    describe "Finish game" do

      let(:task1) {create :task}
      let!(:user_task1) {create :user_task, user: user, task: task1, result: 3}
      let!(:game_task1) {create :game_task, game: game, task: task1}
      #user_task1 = FactoryGirl.create(:user_task, task_id: @task1.to_param, user_id: @user.to_param, result: 3)

      before(:each) do
        Game.find(game.id).update(state: UserGame::CURRENT)
        UserGame.where(user_id: user.id, game_id: game.id).first.update(state: UserGame::CURRENT)
      end

      it "check game status as equal to COMPLETED" do
        game.finish_game
        expect(Game.find(game.id).state).to eq(UserGame::COMPLETED)
      end

      it "check user_game status as equal to COMPLETED" do
        game.finish_game
        expect(UserGame.where(user_id: user.id, game_id: game.id).first.state).to eq(UserGame::COMPLETED)
      end

      it "check user_game points count as equal to user_tasks results sum " do
        game.finish_game
        expect(UserGame.where(user_id: user.id, game_id: game.id).first.result).to eq(user_task.result + user_task1.result)
      end

    end
  end

  describe "get_task_codes_count" do

    let!(:code_compare) {create :code_compare, code: code, user: user}

    it "returns array with code_compare forms count" do
      Game.find(game.id).update(state: UserGame::CURRENT)
      expect(game.get_task_codes_count(task, user) == [CodeCompare.count, TaskCode.count - CodeCompare.count])
    end

  end

end
