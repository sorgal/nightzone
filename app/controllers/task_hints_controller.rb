class TaskHintsController < ApplicationController
  before_action :set_task_hint, only: [:destroy]

  def create
    @task_hint = TaskHint.new(task_hint_params)

    respond_to do |format|
      if @task_hint.save
        format.html { head :no_content }
        format.json { head :no_content }
      else
        format.html { head :no_content }
        format.json { head :no_content }
      end
    end
  end

  # DELETE /task_hints/1
  # DELETE /task_hints/1.json
  def destroy
    @task_hint.destroy
    respond_to do |format|
      format.html { head :no_content }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task_hint
      @task_hint = TaskHint.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_hint_params
      params.require(:task_hint).permit(:task_id, :hint_id)
    end
end
