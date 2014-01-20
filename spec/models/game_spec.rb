require 'spec_helper'

describe Game do

  before do
    @user = FactoryGirl.create(:user)
    @game = FactoryGirl.create(:game)
    @code = FactoryGirl.create(:code)
    @task = FactoryGirl.create(:task)
    @user_task = FactoryGirl.create(:user_task, user_id: @user.to_param, task_id: @task.to_param, result: 3)
    @task_code = FactoryGirl.create(:task_code, task_id: @task.to_param, code_id: @code.to_param)
    @task_game = FactoryGirl.create(:game_task, game_id: @game.to_param, task_id: @task.to_param)
    @user_game = FactoryGirl.create(:user_game, user_id: @user.to_param, game_id: @game.to_param, state: 1)
  end

  it "games validation checking" do
    @game.should be_valid
  end

  describe "create code compare testing" do

    it "code compare processing" do
      count = CodeCompare.count
      expect(@game.process(@user, @task, @code.code_string) == "Code was matched. Game completed")
      expect(CodeCompare.count).to eq(count + 1)
    end

     it "creates a new CodeCompare and end the game of current user" do
      expect(@game.process(@user, @task, @code.code_string) == "Code was matched. Game completed")
      expect(UserGame.find(@user_game.to_param.to_i).state).to eq(-1)
    end

    it "creates a new CodeCompare with code mismatched result" do
      expect(@game.process(@user, @task, @code.attributes["code_string"] + "egbrhnjtyhjnawfgbh") == "Code or pass was not matched")
      expect(UserTask.last.task_id).to eq(@task.to_param.to_i)
      expect(UserGame.find(@user_game.to_param.to_i).state).to eq(1)
    end

    it "send valid pass with complete of user game" do
      expect(@game.process(@user, @task, "1234567890") == "Code was matched. Game completed")
      expect(UserGame.find(@user_game.to_param.to_i).state).to eq(-1)
    end
    describe "assign next task" do
      before(:each) do
        @new_task = FactoryGirl.create(:task, task_text: "sdgbhdrhndrbhzsgfr")
        @new_code = FactoryGirl.create(:code, code_string: "dfbdfbndfgnhdfgdfh")
        @new_user_task = FactoryGirl.build(:user_task, user_id: @user.to_param, task_id: @new_task.to_param)
        @new_task_code = FactoryGirl.create(:task_code, task_id: @new_task.to_param, code_id: @new_code.to_param)
        @new_task_game = FactoryGirl.create(:game_task, game_id: @game.to_param, task_id: @new_task.to_param)
      end
      it "creates a new CodeCompare and change task" do
        expect(@game.process(@user, @task, "1234567890") == "Code was matched. Next task assigned")
        expect(UserTask.last.task_id).to eq(@new_task.to_param.to_i)
      end
      it "code compare processing and change" do
        expect(@game.process(@user, @task, @code.attributes["code_string"]) == "Code was matched. Next task assigned")
        expect(UserTask.last.task_id).to eq(@new_task.to_param.to_i)
      end
    end
  end
  describe "Start and finish game" do
    describe "Start game" do
       it "execute action " do
        expect {
          @game.start_game
        }.to change(UserTask, :count).by(1)
      end

      it "check game state equal to CURRENT" do
        @game.start_game
        expect(Game.find(@game.to_param.to_i).state).to equal(UserGame::CURRENT)
      end

      it "check user_game state equal to CURRENT" do
        @game.start_game
        expect(UserGame.where(user_id: @user.to_param, game_id:@game.to_param.to_i).first.state).to equal(UserGame::CURRENT)
      end

    end

    describe "Finish game" do

      before(:each) do
        @task1 = FactoryGirl.create(:task)
        @user_task1 = FactoryGirl.create(:user_task, task_id: @task1.to_param, user_id: @user.to_param, result: 3)
      end

      it "check game status as equal to COMPLETED" do
        @game.finish_game
        expect(Game.find(@game.to_param.to_i).state).to eq(UserGame::COMPLETED)
      end

      it "check user_game status as equal to COMPLETED" do
        @game.finish_game
        expect(UserGame.where(user_id: @user.to_param, game_id:@game.to_param.to_i).first.state).to eq(UserGame::COMPLETED)
      end

      it "check user_game points count as equal to user_tasks results sum " do
       @game.finish_game
        expect(UserGame.where(user_id: @user.to_param, game_id:@game.to_param.to_i).first.result).to eq(@user_task.result + @user_task1.result)
      end

    end
  end
end
