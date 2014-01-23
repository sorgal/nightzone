require 'spec_helper'

describe CodesController do
  login_admin

  let(:valid_session) { {} }

  let(:task) {create :task}

  let!(:code) {create :code}

  let(:invalid_attributes) {build :code, code_string: "ывампывипа"}

  let!(:valid_attributes) {build :code, code_string: "eghrfhfhfh"}

  let!(:task_code) {create :task_code, task: task, code: code}

  describe "GET index" do
    it "assigns all codes as @codes" do
      get :index, {}, valid_session
      expect(assigns(:codes)).to eq([code])
    end
  end

  describe "GET show" do

    let(:game) {create :game}

    let!(:task_game) {create :game_task, task: task, game: game}

    it "assigns the requested code as @code" do
      get :show, {id: code.id}, valid_session
      expect(assigns(:code)).to eq(code)
    end

  end

  describe "GET new" do

    let!(:game) {create :game}

    let!(:task_game) {create :game_task, task: task, game: game}

    it "assigns a new code as @code" do
      get :new, {task: task.id}, valid_session
      expect(assigns(:code)).to be_a_new(Code)
    end

    describe "when game was started or finished" do

      it "tries to create a new Code when game was started" do
        Game.find(game.id).update(state: UserGame::CURRENT)
        get :new, {task: task.id}, valid_session
        expect(response).to redirect_to(task_path(task))
      end

      it "tries to create a new Code when game was finished" do
        Game.find(game.id).update(state: UserGame::COMPLETED)
        get :new, {task: task.id}, valid_session
        expect(response).to redirect_to(task_path(task))
      end


    end


  end

  describe "GET edit" do
    it "assigns the requested code as @code" do
      get :edit, {id: code.id}, valid_session
      expect(assigns(:code)).to eq(code)
    end
  end

  describe "POST create" do
    before(:each) do
      @code_post = code.attributes
      @code_post[:task] = task.id
      @code_post_invalid = invalid_attributes.attributes
      @code_post_invalid[:task] = task.id
    end


    describe "with valid params" do
      it "creates a new Code" do
        expect {
          post :create, {code: @code_post}, valid_session
        }.to change(Code, :count).by(1)
      end

      it "assigns a newly created code as @code" do
        post :create, {code: @code_post}, valid_session
        expect(assigns(:code)).to be_a(Code)
        expect(assigns(:code)).to be_persisted
      end

      it "redirects to the created code" do
        post :create, {code: @code_post}, valid_session
        expect(response).to redirect_to(Code.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved code as @code" do
        Code.any_instance.stub(:save).and_return(false)
        post :create, {code: @code_post_invalid}, valid_session
        expect(assigns(:code)).to be_a_new(Code)
      end

      it "re-renders the 'new' template" do
        Code.any_instance.stub(:save).and_return(false)
        post :create, {code: @code_post_invalid}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do

      it "updates the requested code" do
        expect_any_instance_of(Code).to receive(:update).with({ "code_string" => valid_attributes.code_string })
        put :update, {id: code.id, code: { "code_string" => valid_attributes.code_string }}, valid_session
      end

      it "assigns the requested code as @code" do
        put :update, {id: code.id, code: valid_attributes.attributes}, valid_session
        expect(assigns(:code)).to eq(code)
      end

      it "redirects to the code" do
        put :update, {id: code.id, code: valid_attributes.attributes}, valid_session
        expect(response).to redirect_to(code)
      end
    end

    describe "with invalid params" do
      it "assigns the code as @code" do
        Code.any_instance.stub(:save).and_return(false)
        put :update, {id: code.id, code: invalid_attributes.attributes}, valid_session
        expect(assigns(:code)).to eq(code)
      end

      it "re-renders the 'edit' template" do

        Code.any_instance.stub(:save).and_return(false)
        put :update, {id: code.id, code: invalid_attributes.attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested code" do
      expect {
        delete :destroy, {id: code.id}, valid_session
      }.to change(Code, :count).by(-1)
    end

    it "redirects to the codes list" do
      delete :destroy, {id: code.id}, valid_session
      expect(response).to redirect_to(codes_url)
    end
  end

end
