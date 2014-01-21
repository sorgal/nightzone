class AdminGamesController < ApplicationController
  before_action :set_admin_game, only: [:destroy]

  # POST /admin_games
  # POST /admin_games.json
  def create
    @admin_game = AdminGame.new(admin_game_params)

    respond_to do |format|
      if @admin_game.save
        format.html { head :no_content }
        format.json { head :no_content }
      else
        format.html { head :no_content }
        format.json { head :no_content }
      end
    end
  end

   # DELETE /admin_games/1
  # DELETE /admin_games/1.json
  def destroy
    @admin_game.destroy
    respond_to do |format|
      format.html { head :no_content }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_game
      @admin_game = AdminGame.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_game_params
      params.require(:admin_game).permit(:admin_user_id, :game_id)
    end
end
