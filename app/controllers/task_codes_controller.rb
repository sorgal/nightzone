class TaskCodesController < ApplicationController
  before_action :set_task_code, only: [:destroy]

 def create
    @task_code = TaskCode.new(task_code_params)

    respond_to do |format|
      if @task_code.save
        format.html { head :no_content }
        format.json { head :no_content }
      else
        format.html { head :no_content }
        format.json { head :no_content }
      end
    end
  end

  # DELETE /task_codes/1
  # DELETE /task_codes/1.json
  def destroy
    @task_code.destroy
    respond_to do |format|
      format.html { head :no_content }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task_code
      @task_code = TaskCode.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_code_params
      params.require(:task_code).permit(:task_id, :code_id)
    end
end
