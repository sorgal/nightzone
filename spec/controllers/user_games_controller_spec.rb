require 'spec_helper'

describe UserGamesController do
  login_user
  render_views

  let(:valid_session) { {} }

  let(:game) {create :game}

  let!(:user_game) {create :user_game, user: @user, game: game, result: 0}

  let(:invalid_attributes) {build :user_game, user: @user, game: game, result: "aerg"}

  let(:valid_attributes) {build :user_game, user: @user, game: game, result: 10}

  describe "GET index" do
    it "assigns all user_games as @user_games" do
      get :index, {}, valid_session
      expect(assigns(:user_games)).to eq([user_game])
    end
  end

  describe "GET show" do
    it "assigns the requested user_game as @user_game" do
      get :show, {id: user_game.id}, valid_session
      expect(assigns(:user_game)).to eq(user_game)
    end
  end

  describe "GET new" do
    it "assigns a new user_game as @user_game" do
      get :new, {}, valid_session
      expect(assigns(:user_game)).to be_a_new(UserGame)
    end
  end

  describe "GET edit" do
    it "assigns the requested user_game as @user_game" do
      get :edit, {id: user_game.id}, valid_session
      expect(assigns(:user_game)).to eq(user_game)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new UserGame" do
        expect {
          post :create, {game_id: game.id}, valid_session
        }.to change(UserGame, :count).by(1)
      end

      it "assigns a newly created user_game as @user_game" do
        post :create, {game_id: game.id}, valid_session
        expect(assigns(:user_game)).to be_a(UserGame)
        expect(assigns(:user_game)).to be_persisted
      end

      it "redirects to the created users games list" do
        post :create, {game_id: game.id}, valid_session
        expect(response).to redirect_to(user_games_url)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved user_game as @user_game" do
        UserGame.any_instance.stub(:save).and_return(false)
        post :create, {game_id: game.id}, valid_session
        expect(assigns(:user_game)).to be_a_new(UserGame)
      end

      it "redirect the root template" do
        # Trigger the behavior that occurs when invalid params are submitted
        UserGame.any_instance.stub(:save).and_return(false)
        post :create, {game_id: game.id}, valid_session
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested user_game" do
        expect_any_instance_of(UserGame).to receive(:update).with({ "user_id" => "#{@user.id}" })
        put :update, {id: user_game.id, user_game: { "user_id" => @user.id }}, valid_session
      end

      it "assigns the requested user_game as @user_game" do
        put :update, {id: user_game.id, user_game: valid_attributes.attributes}, valid_session
        expect(assigns(:user_game)).to eq(user_game)
      end

      it "redirects to the user_game" do
        put :update, {id: user_game.id, user_game: valid_attributes.attributes}, valid_session
        expect(response).to redirect_to(user_game)
      end
    end

    describe "with invalid params" do
      it "assigns the user_game as @user_game" do
        UserGame.any_instance.stub(:save).and_return(false)
        put :update, {id: user_game.id, user_game: invalid_attributes.attributes}, valid_session
        expect(assigns(:user_game)).to eq(user_game)
      end

      it "re-renders the 'edit' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        UserGame.any_instance.stub(:save).and_return(false)
        put :update, {id: user_game.id, user_game: invalid_attributes.attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested user_game" do
      expect {
        delete :destroy, {id: user_game.id}, valid_session
      }.to change(UserGame, :count).by(-1)
    end

    it "redirects to the user_games list" do
      delete :destroy, {id: user_game.id}, valid_session
      expect(response).to redirect_to(user_games_url)
    end
  end

end
