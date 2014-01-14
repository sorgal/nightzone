require 'spec_helper'

describe HomeController do
  login_user
  render_views
  let(:valid_session) { {} }

  before do
    @game = FactoryGirl.create(:game)
    @code = FactoryGirl.create(:code)
  end

  describe "GET 'index'" do
    it "returns http success" do
      get "index", {}, valid_session
      expect(assigns(:games)).to eq([@game])
    end
  end

  describe "GET 'game_code_compares'" do
    it "returns http success" do
      get 'game_code_compares', {game: @game.to_param}, valid_session
      expect(response).to be_success
    end
  end

  describe "GET 'create_code_compare'" do
    it "returns http success" do
      expect {
        post "create_code_compare", {game: @game.to_param, try_text: @code.attributes[:code_text]}, valid_session
      }.to change(CodeCompare, :count).by(1)
    end
  end

end
