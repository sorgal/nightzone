class GameCodesController < ApplicationController
  before_action :set_game_code, only: [:show, :edit, :update, :destroy]

  # POST /game_codes
  # POST /game_codes.json
  def create
    @game_code = GameCode.new(game_code_params)

    respond_to do |format|
      if @game_code.save
        format.html { head :no_content }
        format.json { head :no_content }
      else
        format.html { head :no_content }
        format.json { head :no_content }
      end
    end
  end


  # DELETE /game_codes/1
  # DELETE /game_codes/1.json
  def destroy
    @game_code.destroy
    respond_to do |format|
      format.html { head :no_content }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game_code
      @game_code = GameCode.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_code_params
      params.require(:game_code).permit(:game_id, :code_id)
    end
end
