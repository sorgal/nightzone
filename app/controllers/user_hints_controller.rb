class UserHintsController < ApplicationController
  before_action :set_user_hint, only: [:destroy]
  before_filter :authenticate_user!
  skip_before_filter :authorize_admin

  # POST /user_hints
  # POST /user_hints.json
  def create
    @user_hint = UserHint.new(user_hint_params)

    respond_to do |format|
      if @user_hint.save
        format.html { head :no_content }
        format.json { head :no_content }
      else
        format.html { head :no_content }
        format.json { head :no_content }
      end
    end
  end

  # DELETE /user_hints/1
  # DELETE /user_hints/1.json
  def destroy
    @user_hint.destroy
    respond_to do |format|
      format.html { head :no_content }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_hint
      @user_hint = UserHint.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_hint_params
      params.require(:user_hint).permit(:user_id, :hint_id)
    end
end
