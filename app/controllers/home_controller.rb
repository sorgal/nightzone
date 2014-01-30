class HomeController < ApplicationController
  skip_before_filter :authorize_admin
  before_filter :authenticate_user!, only: [:game_code_compares, :create_code_compare]

  def index
    if user_signed_in?
      @games = Game.where("`state` >= ?", 0)
      @user_games = current_user.user_games
    end
  end

  def sendbc
    message = {:channel => '/games', :data => "alert(1)"}
    uri = URI.parse("http://localhost:9292/faye")
    Net::HTTP.post_form(uri, :message => message.to_json)
    head :ok
  end
end
