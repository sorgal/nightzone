class CodeComparesController < ApplicationController
  before_action :set_code_compare, only: [:destroy]
  skip_before_filter :authorize_admin
  def create
    @code_compare = CodeCompare.new(code_compare_params)

    respond_to do |format|
      if @code_compare.save
        format.html { head :no_content }
        format.json { head :no_content }
      else
        format.html { head :no_content }
        format.json { head :no_content }
      end
    end
  end

  def destroy
    @code_compare.destroy
    respond_to do |format|
      format.html { head :no_content }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_code_compare
    @code_compare = CodeCompare.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def code_compare_params
    params.require(:code_compare).permit(:user_id, :code_id)
  end
end
