class UserTasksController < ApplicationController
  before_action :set_user_task, only: [:destroy]
  skip_before_filter :authorize_admin
  before_filter :authenticate_user!

  def create
    @user_task = UserTask.new(user_task_params)

    respond_to do |format|
      if @user_task.save
        format.html { head :no_content }
        format.json { head :no_content }
      else
        format.html { head :no_content }
        format.json { head :no_content }
      end
    end
  end

  # DELETE /user_tasks/1
  # DELETE /user_tasks/1.json
  def destroy
    @user_task.destroy
    respond_to do |format|
      format.html { head :no_content }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_task
      @user_task = UserTask.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_task_params
      params.require(:user_task).permit(:user_id, :task_id, :result)
    end
end
