require 'spec_helper'

describe UserHintsController do
  login_user

  let(:valid_attributes) { { "user_id" => "1" } }

  let(:valid_session) { {} }

  let(:hint) {create :hint}

  let!(:user_hint) {create :user_hint, user: @user, hint: hint}

  describe "POST create" do
    describe "with valid params" do
      it "creates a new UserHint" do
        expect {
          post :create, {user_hint: user_hint.attributes}, valid_session
        }.to change(UserHint, :count).by(1)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested user_hint" do
      expect {
        delete :destroy, {id: user_hint.id}, valid_session
      }.to change(UserHint, :count).by(-1)
    end
  end

end
