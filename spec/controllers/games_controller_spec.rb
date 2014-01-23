require 'spec_helper'

describe GamesController do

  let(:valid_session) { {} }

  let!(:game) {create :game}

  let!(:task) {create :task}

  let!(:game_task) {create :game_task, game: game, task: task}

  let(:invalid_attributes) {build :game, title: "впирапеи"}

  let(:valid_attributes) {build :game, title: "title_1"}

  let(:code) {create :code}

  let!(:task_code) {create :task_code, task: task, code: code}

  describe "without sign in" do
    describe "GET show" do
      it "assigns the requested game as @game" do
        get :show, {id: game.id}, valid_session
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "with sign in" do
    login_admin

    describe "GET index" do
      login_user
      it "assigns all games as @games" do
        get :index, {}, valid_session
        expect(assigns(:games)).to eq([game])
      end
    end

    describe "GET show" do
      login_user

      let!(:code_compare) {create :code_compare, code: code, user: @user}

      let!(:user_task) {create :user_task, task: task, user: @user}

      it "assigns the requested game as @game" do
        get :show, {id: game.id}, valid_session
        expect(assigns(:game)).to eq(game)
      end

      it "returns array with code_compare forms count" do
        Game.find(game.id).update(state: UserGame::CURRENT)
        get :show, {id: game.id}, valid_session
        expect(assigns(:arr) == [CodeCompare.count, TaskCode.count - CodeCompare.count])
      end

    end

    describe "GET new" do
      it "assigns a new game as @game" do
        get :new, {}, valid_session
        expect(assigns(:game)).to be_a_new(Game)
      end
    end

    describe "GET edit" do
      it "assigns the requested game as @game" do
        get :edit, {id: game.id}, valid_session
        expect(assigns(:game)).to eq(game)
      end
    end

    describe "POST create" do
      before(:each) do
        @valid_attributes = valid_attributes.attributes
        @invalid_attributes = invalid_attributes
      end
      describe "with valid params" do
        it "creates a new Game" do
          expect {
            post :create, {game: valid_attributes.attributes}, valid_session
          }.to change(Game, :count).by(1)
        end

        it "assigns a newly created game as @game" do
          post :create, {game: valid_attributes.attributes}, valid_session
          expect(assigns(:game)).to be_a(Game)
          expect(assigns(:game)).to be_persisted
        end

        it "redirects to the created game" do
          post :create, {game: valid_attributes.attributes}, valid_session
          expect(response).to redirect_to(Game.last)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved game as @game" do
          Game.any_instance.stub(:save).and_return(false)
          post :create, {game: invalid_attributes.attributes}, valid_session
          expect(assigns(:game)).to be_a_new(Game)
        end

        it "re-renders the 'new' template" do
          Game.any_instance.stub(:save).and_return(false)
          post :create, {game: invalid_attributes.attributes}, valid_session
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested game" do
          expect_any_instance_of(Game).to receive(:update).with({ "title" => valid_attributes.title })
          put :update, {id: game.id, game: { "title" => valid_attributes.title }}, valid_session
        end

        it "assigns the requested game as @game" do
          put :update, {id: game.id, game: { title: valid_attributes.title }}, valid_session
          expect(assigns(:game)).to eq(game)
        end

        it "redirects to the game" do
          put :update, {id: game.id, game: { title: valid_attributes.title }}, valid_session
          expect(response).to redirect_to(game)
        end
      end

      describe "with invalid params" do
        it "assigns the game as @game" do
          Game.any_instance.stub(:save).and_return(false)
          put :update, {id: game.id, game: { title: invalid_attributes.title }}, valid_session
          expect(assigns(:game)).to eq(game)
        end

        it "re-renders the 'edit' template" do
          Game.any_instance.stub(:save).and_return(false)
          put :update, {id: game.id, game: { title: invalid_attributes.title }}, valid_session
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested game" do
        expect {
          delete :destroy, {id: game.id}, valid_session
        }.to change(Game, :count).by(-1)
      end

      it "redirects to the games list" do
        delete :destroy, {id: game.id}, valid_session
        expect(response).to redirect_to(games_url)
      end
    end

    describe "Start and finish game" do

      let!(:user) {create :user}

      let!(:user_game) {create :user_game, game: game, user: user}

      describe "Start game" do
        describe "start intact game" do
          it "execute action " do
            expect {
              get "start_game", {id: game.id}, valid_session
            }.to change(UserTask, :count).by(1)
          end

          it "check game state equal to CURRENT" do
            get "start_game", {id: game.id}, valid_session
            expect(Game.find(game.id).state).to equal(UserGame::CURRENT)
          end

          it "check user_game state equal to CURRENT" do
            get "start_game", {id: game.id}, valid_session
            expect(UserGame.where(user_id: user.id, game_id: game.id).first.state).to equal(UserGame::CURRENT)
          end
        end

        describe "start already started or finished game" do

          it "starts already started game" do
            Game.find(game.id).update(state: UserGame::CURRENT)
            expect {
              get "start_game", {id: game.id}, valid_session
            }.to change(UserTask, :count).by(0)
            expect(response).to redirect_to(game_path(game))
          end

          it "starts already finished game" do
            Game.find(game.id).update(state: UserGame::COMPLETED)
            expect {
              get "start_game", {id: game.id}, valid_session
            }.to change(UserTask, :count).by(0)
            expect(response).to redirect_to(game_path(game))
          end


        end

      end

      describe "Finish game" do

        let(:task1) {create :task}

        let!(:user_task) {create :user_task, user: user, task: task, result: 3}

        let!(:user_task1) {create :user_task, user: user, task: task1, result: 3}

        let!(:game_task1) {create :game_task, game: game, task: task1}

        before(:each) do
          Game.find(game.id).update(state: UserGame::CURRENT)
          UserGame.where(user_id: user.id, game_id: game.id).first.update(state: UserGame::CURRENT)
        end

        it "check game status as equal to COMPLETED" do
          get "finish_game", {id: game.id}, valid_session
          expect(Game.find(game.id).state).to eq(UserGame::COMPLETED)
        end

        it "check user_game status as equal to COMPLETED" do
          get "finish_game", {id: game.id}, valid_session
          expect(UserGame.where(user_id: user.id, game_id: game.id).first.state).to eq(UserGame::COMPLETED)
        end

        it "check user_game points count as equal to user_tasks results sum " do
          get "finish_game", {id: game.id}, valid_session
          expect(UserGame.where(user_id: user.id, game_id: game.id).first.result).to eq(user_task.result + user_task1.result)
        end

        describe "finsh not started or finished game" do

          it "finish not started game" do
            Game.find(game.id).update(state: UserGame::INTACT)
            expect {
              get "finish_game", {id: game.id}, valid_session
            }.to change(UserTask, :count).by(0)
            expect(response).to redirect_to(game_path(game))
          end

          it "starts already finished game" do
            Game.find(game.id).update(state: UserGame::COMPLETED)
            expect {
              get "start_game", {id: game.id}, valid_session
            }.to change(UserTask, :count).by(0)
            expect(response).to redirect_to(game_path(game))
          end


        end

      end
    end
  end
end
