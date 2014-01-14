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

describe CodesController do
  login_admin
  # This should return the minimal set of attributes required to create a valid
  # Code. As you add validations to Code, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { {  } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # CodesController. Be sure to keep this updated too.
  let(:valid_session) { {} }
  before do
    @game = FactoryGirl.create(:game)
    @code = FactoryGirl.create(:code)
    @invalid_attributes = FactoryGirl.build(:code, code_string: "ывампывипа").attributes
  end

  describe "GET index" do
    it "assigns all codes as @codes" do
      get :index, {}, valid_session
      expect(assigns(:codes)).to eq([@code])
    end
  end

  describe "GET show" do
    it "assigns the requested code as @code" do
      get :show, {:id => @code.to_param}, valid_session
      expect(assigns(:code)).to eq(@code)
    end
  end

  describe "GET new" do
    it "assigns a new code as @code" do
      get :new, {game: @game.to_param}, valid_session
      expect(assigns(:code)).to be_a_new(Code)
    end
  end

  describe "GET edit" do
    it "assigns the requested code as @code" do
      get :edit, {:id => @code.to_param}, valid_session
      expect(assigns(:code)).to eq(@code)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Code" do
        expect {
          post :create, {:code => @code.attributes}, valid_session
        }.to change(Code, :count).by(1)
      end

      it "assigns a newly created code as @code" do
        post :create, {:code => @code.attributes}, valid_session
        expect(assigns(:code)).to be_a(Code)
        expect(assigns(:code)).to be_persisted
      end

      it "redirects to the created code" do
        post :create, {:code => @code.attributes}, valid_session
        expect(response).to redirect_to(Code.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved code as @code" do
        # Trigger the behavior that occurs when invalid params are submitted
        Code.any_instance.stub(:save).and_return(false)
        post :create, {:code => @invalid_attributes}, valid_session
        expect(assigns(:code)).to be_a_new(Code)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Code.any_instance.stub(:save).and_return(false)
        post :create, {:code => @invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      before (:each) do
        @valid_attributes = FactoryGirl.build(:code, code_string: "dzfvbzjfgnarmkgnhbmargtgbhsergnerf;").attributes
      end
      it "updates the requested code" do
        # Assuming there are no other codes in the database, this
        # specifies that the Code created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        expect_any_instance_of(Code).to receive(:update).with({ "code_string" => "sdfgsdgfdf" })
        put :update, {:id => @code.to_param, :code => { "code_string" => "sdfgsdgfdf" }}, valid_session
      end

      it "assigns the requested code as @code" do
        put :update, {:id => @code.to_param, :code => @valid_attributes}, valid_session
        expect(assigns(:code)).to eq(@code)
      end

      it "redirects to the code" do
        put :update, {:id => @code.to_param, :code => @valid_attributes}, valid_session
        expect(response).to redirect_to(@code)
      end
    end

    describe "with invalid params" do
      it "assigns the code as @code" do
        Code.any_instance.stub(:save).and_return(false)
        put :update, {:id => @code.to_param, :code => @invalid_attributes}, valid_session
        expect(assigns(:code)).to eq(@code)
      end

      it "re-renders the 'edit' template" do

        Code.any_instance.stub(:save).and_return(false)
        put :update, {:id => @code.to_param, :code => @invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested code" do
      expect {
        delete :destroy, {:id => @code.to_param}, valid_session
      }.to change(Code, :count).by(-1)
    end

    it "redirects to the codes list" do
      delete :destroy, {:id => @code.to_param}, valid_session
      expect(response).to redirect_to(codes_url)
    end
  end

end
