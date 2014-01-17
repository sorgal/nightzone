class CodeComparesController < ApplicationController
  before_action :set_code_compare, only: [:destroy]
  skip_before_filter :authorize_admin
  before_filter :check_code_compare_creation, only: [:create]
  before_filter :authenticate_user!

  def create
    @task = current_user.tasks.last
    @game = @task.game

    notice = ""
    notice = @game.process(current_user, @task, params[:try_text])

    respond_to do |format|
      format.html { redirect_to game_path(id: @game.id), notice: notice }
      format.json { head :no_content }
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


  protected

  def check_code_compare_creation
    unless params[:try_text] && params[:task]
      @game = @task.game
      redirect_to game_path(id: @game.game)
    end
  end

  def pass_matching(text)
    if User.find(current_user.id).valid_password?(text)
      return true
    else
      return false
    end
  end

  def next_task(points)
    if has_more_tasks?
      assign_next_task(points)
      "Next task assigned"
    else
      end_game
      "Game completed"
    end
  end

  def has_more_tasks?
    untaken_tasks.any?
  end

  def assign_next_task(points)
    current_user.user_tasks.last.update_attribute(:result, points)
    current_user.user_tasks.create(task: untaken_tasks.first)
  end

  def end_game
    current_user.user_games.current.first.update_attribute(:state, UserGame::COMPLETED)
  end

  def untaken_tasks
    completed_ids = @game.tasks.for_user(current_user.id).pluck(:id)
    @untaken_tasks ||= @game.tasks.where('`tasks`.`id` NOT IN (?)', completed_ids.join(',') )
  end

end