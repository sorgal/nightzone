class HomeController < ApplicationController
  skip_before_filter :authorize_admin
  before_filter :authenticate_user!, only: [:game_code_compares, :create_code_compare]

  def index
    @games = Game.all
  end

  def game_code_compares
    @game = Game.find(params[:game].to_i)
    @game_codes = GameCode.where(game_id: @game.id)
  end

  def create_code_compare
    @code = Code.where(params[:try_text])
    if @code.count > 0
      code_compare_params = {}
      code_compare_params[:code_compare] = {user_id: current_user.id, game_id: params[:game].to_i}
      CodeCompare.create(code_compare_params)
    else
      redirect_to "home/game_code_compares", notice: "Code does not match"
    end
  end

end
