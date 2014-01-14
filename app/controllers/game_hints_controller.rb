class GameHintsController < ApplicationController
  before_action :set_game_hint, only: [:destroy]

  # POST /game_hints
  # POST /game_hints.json
  def create
    @game_hint = GameHint.new(game_hint_params)

    respond_to do |format|
      if @game_hint.save
        format.html { head :no_content }
        format.json { head :no_content }
      else
        format.html { head :no_content }
        format.json { head :no_content }
      end
    end
  end

  def destroy
    @game_hint.destroy
    respond_to do |format|
      format.html { head :no_content }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game_hint
      @game_hint = GameHint.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_hint_params
      params.require(:game_hint).permit(:game_id, :hint_id)
    end
end
