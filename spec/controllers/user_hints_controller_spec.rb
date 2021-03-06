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

describe UserHintsController do
  login_user
  # This should return the minimal set of attributes required to create a valid
  # UserHint. As you add validations to UserHint, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "user_id" => "1" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # UserHintsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  before do
    @hint = FactoryGirl.create(:hint)
    @user_hint = FactoryGirl.create(:user_hint, user_id: @user_id, hint_id: @hint.to_param)
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new UserHint" do
        expect {
          post :create, {:user_hint => @user_hint.attributes}, valid_session
        }.to change(UserHint, :count).by(1)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested user_hint" do
      expect {
        delete :destroy, {:id => @user_hint.to_param}, valid_session
      }.to change(UserHint, :count).by(-1)
    end
  end

end
