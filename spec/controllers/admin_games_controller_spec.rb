require 'spec_helper'


describe AdminGamesController do
  login_admin

  let(:valid_attributes) { { "admin_id" => "1" } }

  let(:valid_session) { {} }

  let(:game) {create :game}

  let!(:admin_game) {create :admin_game, game: game, admin_user: @admin}

  describe "POST create" do
    describe "with valid params" do
      it "creates a new AdminGame" do
        expect {
          post :create, {admin_game: admin_game.attributes}, valid_session
        }.to change(AdminGame, :count).by(1)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested admin_game" do
      expect {
        delete :destroy, {id: admin_game.id}, valid_session
      }.to change(AdminGame, :count).by(-1)
    end
  end

end
