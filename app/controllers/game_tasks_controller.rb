class GameTasksController < ApplicationController
  before_action :set_game_task, only: [:show, :edit, :update, :destroy]

  # POST /game_tasks
  # POST /game_tasks.json
  def create
    @game_task = GameTask.new(game_task_params)

    respond_to do |format|
      if @game_task.save
        format.html { head :no_content }
        format.json { head :no_content }
      else
        format.html { head :no_content }
        format.json { head :no_content }
      end
    end
  end

  # DELETE /game_tasks/1
  # DELETE /game_tasks/1.json
  def destroy
    @game_task.destroy
    respond_to do |format|
      format.html { head :no_content }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game_task
      @game_task = GameTask.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_task_params
      params.require(:game_task).permit(:game_id, :task_id)
    end
end
