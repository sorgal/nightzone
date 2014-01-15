require 'spec_helper'

describe HomeController do
  login_user
  render_views
  let(:valid_session) { {} }

  before do
    @game = FactoryGirl.create(:game)
    @code = FactoryGirl.create(:code)
   # @game_code = FactoryGirl.create(:game_code, game_id: @game.to_param, code_id: @code.to_param)
  end

  describe "GET 'index'" do
    it "returns http success" do
      get "index", {}, valid_session
      expect(assigns(:games)).to eq([@game])
    end
  end

end
