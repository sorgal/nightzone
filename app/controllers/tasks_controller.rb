class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :raise_hint]
  before_filter :check_game, only: [:new]
  before_filter :check_game_create, only: [:create]
  before_filter :no_tasks, except: [:new, :create]
  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    game = params.require(:task)[:game].to_i
    respond_to do |format|
      if @task.save
        if GameTask.create(game_id: game, task_id: @task.id)
          format.html { redirect_to @task, notice: 'Task was successfully created.' }
          format.json { render action: 'show', status: :created, location: @code }
        end
      else
        format.html { render action: 'new' }
        format.json { render json: @code.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:task_text, :points)
    end

  protected

    def check_game
      unless params.require(:game)
        redirect_to games_path
      end
    end

    def check_game_create
      unless params.require(:task)[:game]
        redirect_to games_path
      end
    end

    def no_tasks
      unless Task.all.count > 0
        redirect_to games_path
      end
    end

  public
    #еще заглушка
    def raise_hint
      TaskHint.where(task_id: @task.id).each do |task_hint|
        @hint = Hint.find(task_hint.hint_id)
        if UserHint.where(hint_id: @hint.id).count > 0
          next
        else
          @user_tasks = UserTask.where(task_id: task_hint.task_id)
          @user_tasks.each do |user_task|
            if user_task.result < 0
              UserHint.create(user_id: user_task.user_id, hint_id: @hint.id)

            end
          end
          break
        end
      end

      redirect_to tasks_path
    end

end
