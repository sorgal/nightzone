require 'spec_helper'

describe HintsController do
  login_admin

  let(:valid_session) { {} }

  let!(:task) {create :task}

  let(:hint) {create :hint, queue_number: rand(1...2)}

  let!(:task_hint) {create :task_hint, task: task, hint: hint}

  let(:invalid_attributes) {build :hint, hint_text: "акпыук", queue_number: 3 - hint.queue_number}

  let(:valid_attributes) {build :hint, hint_text: "dzfvbzjfgnarmkgnhbmargtgbhsergnerf;"}

  let(:new_hint) {create :hint}

  let!(:game) {create :game}

  let!(:task_game) {create :game_task, task: task, game: game}

  before(:each) do
    @hint_post = new_hint.attributes
    @hint_post[:task] = task.id
    @hint_post_invalid = invalid_attributes.attributes
    @hint_post_invalid[:task] = task.id
  end

  describe "GET index" do
    it "assigns all hints as @hints" do
      get :index, {}, valid_session
      expect(assigns(:hints)).to eq([hint, new_hint])
    end
  end

  describe "GET show" do
    it "assigns the requested hint as @hint" do
      get :show, {id: hint.id}, valid_session
      expect(assigns(:hint)).to eq(hint)
    end

  end

  describe "GET new" do

    it "assigns a new hint as @hint" do
      get :new, {task: task.id}, valid_session
      expect(assigns(:hint)).to be_a_new(Hint)
    end

    describe "when game was started and finished" do

      it "tries to create a new Hint when game was started" do
        Game.find(game.id).update( state: UserGame::CURRENT)
        get :new, {task: task.id}, valid_session
        expect(response).to redirect_to(task_path(task))
      end

      it "tries to create a new Hint when game was finished" do
        Game.find(game.id).update(state: UserGame::COMPLETED)
        get :new, {task: task.id}, valid_session
        expect(response).to redirect_to(task_path(task))
      end

    end

  end

  describe "new and create actions performing when queue number <= 0 and try to create third task hint" do

    describe "with queue_number <= 0" do
      it "tries to create" do
          @hint_post[:queue_number] = 0
          expect {
            post :create, {:hint => @hint_post}, valid_session
          }.to change(Hint, :count).by(0)
          expect(response).to redirect_to(new_hint_path(task: task.id))
        end
    end

    describe "try to create third task hint and try to access new action" do

      let!(:new_task_hint) {create :task_hint, task: task, hint: new_hint}

      it "creates third hint" do
        expect {
          post :create, {hint: @hint_post}, valid_session
        }.to change(Hint, :count).by(0)
        expect(response).to redirect_to(task_path(task))
      end

      it "tries to new action access" do
        get :new, {task: task.id}, valid_session
        expect(response).to redirect_to(task_path(task))
      end

    end

  end

  describe "GET edit" do
    it "assigns the requested hint as @hint" do
      get :edit, {id: hint.id}, valid_session
      expect(assigns(:hint)).to eq(hint)
    end
  end

  describe "POST create" do

    let(:new_hint) {create :hint, queue_number: 3 - hint.queue_number}

    describe "with valid params" do
      it "creates a new Hint" do
        expect {
          post :create, {hint: @hint_post}, valid_session
        }.to change(Hint, :count).by(1)
      end

      it "assigns a newly created hint as @hint" do
        post :create, {hint: @hint_post}, valid_session
        expect(assigns(:hint)).to be_a(Hint)
        expect(assigns(:hint)).to be_persisted
      end

      it "redirects to the created hint" do
        post :create, {hint: @hint_post}, valid_session
        expect(response).to redirect_to(Hint.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved hint as @hint" do
        Hint.any_instance.stub(:save).and_return(false)
        post :create, {hint: @hint_post_invalid}, valid_session
        expect(assigns(:hint)).to be_a_new(Hint)
      end

      it "re-renders the 'new' template" do
        Hint.any_instance.stub(:save).and_return(false)
        post :create, {hint: @hint_post_invalid}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested hint" do
        expect_any_instance_of(Hint).to receive(:update).with({ "hint_text" => "asfgasdfiasfauhguhawfjawurfh" })
        put :update, {id: hint.id, hint: { "hint_text" => "asfgasdfiasfauhguhawfjawurfh" }}, valid_session
      end

      it "assigns the requested hint as @hint" do
        put :update, {id: hint.id, hint: valid_attributes.attributes}, valid_session
        expect(assigns(:hint)).to eq(hint)
      end

      it "redirects to the hint" do
        put :update, {id: hint.id, hint: valid_attributes.attributes}, valid_session
        expect(response).to redirect_to(hint)
      end
    end

    describe "with invalid params" do
      it "assigns the hint as @hint" do
        Hint.any_instance.stub(:save).and_return(false)
        put :update, {id: hint.id, hint: invalid_attributes.attributes}, valid_session
        expect(assigns(:hint)).to eq(hint)
      end

      it "re-renders the 'edit' template" do
        Hint.any_instance.stub(:save).and_return(false)
        put :update, {id: hint.id, hint: invalid_attributes.attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested hint" do
      expect {
        delete :destroy, {id: hint.id}, valid_session
      }.to change(Hint, :count).by(-1)
    end

    it "redirects to the hints list" do
      delete :destroy, {id: hint.id}, valid_session
      expect(response).to redirect_to(hints_url)
    end
  end

end
