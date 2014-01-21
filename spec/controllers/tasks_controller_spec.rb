require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe TasksController do
  login_admin
  # This should return the minimal set of attributes required to create a valid
  # Task. As you add validations to Task, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { {  } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # TasksController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  let(:game) {create :game}

  let(:task) {create :task}

  let(:hint) {create :hint}

  let!(:user) {create :user}

  let!(:user_task) {create :user_task, user: user, task: task}

  let!(:task_hint) {create :task_hint, task: task, hint: hint}

  let(:hint2) {create :hint, hint_text: " wvgrawrfswf", queue_number: 2}

  let!(:task_hint2) {create :task_hint, task: task, hint: hint2}

  let(:invalid_attributes) {build :task, task_text: "впирапеи"}

  let(:valid_attributes) {build :task, task_text: "zhvnasjfnj"}

  describe "GET index" do
    it "assigns all tasks as @tasks" do
      get :index, {}, valid_session
      expect(assigns(:tasks)).to eq([task])
    end
  end

  describe "GET show" do
    it "assigns the requested task as @task" do
      get :show, {id: task.id}, valid_session
      expect(assigns(:task)).to eq(task)
    end
  end

  describe "GET new" do
    it "assigns a new task as @task" do
      get :new, {game: game.id}, valid_session
      expect(assigns(:task)).to be_a_new(Task)
    end
  end

  describe "GET edit" do
    it "assigns the requested task as @task" do
      get :edit, {id:task.id}, valid_session
      expect(assigns(:task)).to eq(task)
    end
  end

  describe "POST create" do
    before(:each) do
      @task_post = task.attributes
      @task_post[:game] = game.id
      @task_post_invalid = invalid_attributes.attributes
      @task_post_invalid[:game] = game.id
    end
    describe "with valid params" do
      it "creates a new Task" do
        expect {
          post :create, {task: @task_post}, valid_session
        }.to change(Task, :count).by(1)
      end

      it "assigns a newly created task as @task" do
        post :create, {task: @task_post}, valid_session
        expect(assigns(:task)).to be_a(Task)
        expect(assigns(:task)).to be_persisted
      end

      it "redirects to the created task" do
        post :create, {task: @task_post}, valid_session
        expect(response).to redirect_to(Task.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved task as @task" do
        Task.any_instance.stub(:save).and_return(false)
        post :create, {task: @task_post_invalid}, valid_session
        expect(assigns(:task)).to be_a_new(Task)
      end

      it "re-renders the 'new' template" do
        Task.any_instance.stub(:save).and_return(false)
        post :create, {task: @task_post_invalid}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do

      it "updates the requested task" do
        expect_any_instance_of(Task).to receive(:update).with({ "task_text" => "arghbstghset" })
        put :update, {id: task.id, :task => { "task_text" => "arghbstghset" }}, valid_session
      end

      it "assigns the requested task as @task" do
        put :update, {id: task.id, task: valid_attributes.attributes}, valid_session
        expect(assigns(:task)).to eq(task)
      end

      it "redirects to the task" do
        put :update, {id: task.id, task: valid_attributes.attributes}, valid_session
        expect(response).to redirect_to(task)
      end
    end

    describe "with invalid params" do
      it "assigns the task as @task" do
        Task.any_instance.stub(:save).and_return(false)
        put :update, {id: task.id, task: invalid_attributes.attributes}, valid_session
        expect(assigns(:task)).to eq(task)
      end

      it "re-renders the 'edit' template" do
        Task.any_instance.stub(:save).and_return(false)
        put :update, {id: task.id, task: invalid_attributes.attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested task" do
      expect {
        delete :destroy, {id: task.id}, valid_session
      }.to change(Task, :count).by(-1)
    end

    it "redirects to the tasks list" do
      delete :destroy, {id: task.id}, valid_session
      expect(response).to redirect_to(tasks_url)
    end
  end

  describe "Raise hint" do
    it "execute action " do
      expect {
        get "raise_hint", {id: task.id}, valid_session
      }.to change(UserHint, :count).by(1)
    end

    it "raises first hint" do
      expect {
        get "raise_hint", {id: task.id}, valid_session
      }.to change(UserHint, :count).by(1)
      expect(UserHint.last.hint_id).to eq(hint.id)
      expect(UserHint.count).to eq(1)
    end

    describe "hints count > 1" do

      let!(:user_hint) {create :user_hint, user: user, hint: hint}

      before(:each) do
        Hint.find(hint.id).update_attribute(:raised, Hint::RAISED)
      end

      it "raises second hint" do
        expect {
          get "raise_hint", {id: task.id}, valid_session
        }.to change(UserHint, :count).by(1)
        expect(UserHint.last.hint_id).to eq(hint2.id)
        expect(UserHint.count).to eq(2)
      end

      describe "third hint" do
        let!(:user_hint2) {create :user_hint, user: user, hint: hint2}
        it "doesn't raise third hint" do
          Hint.find(hint2.id).update_attribute(:raised, Hint::RAISED)
          expect {
            get "raise_hint", {id: task.id}, valid_session
          }.to change(UserHint, :count).by(0)
          expect(UserHint.last.hint_id).to eq(hint2.id)
          expect(UserHint.count).to eq(2)
        end
      end
    end
  end

end
