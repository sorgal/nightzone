class HintsController < ApplicationController
  before_filter :check_task, only: [:new]
  before_filter :check_task_create, only: [:create]
  before_filter :no_hints, except: [:new, :create]
  before_action :set_hint, only: [:show, :edit, :update, :destroy]

  # GET /hints
  # GET /hints.json
  def index
    @hints = Hint.all
  end

  # GET /hints/1
  # GET /hints/1.json
  def show
    @task = Task.find(@hint.task_hint.task_id)
  end

  # GET /hints/new
  def new
    @task = params[:task].to_i
    @cant_add = false
    if TaskHint.where(task_id: @task).count == 2
      redirect_to task_path(@task), notice: "Only two hints can be assigned with one task"
    end
    @hint = Hint.new
  end

  # GET /hints/1/edit
  def edit
  end

  # POST /hints
  # POST /hints.json
  def create
    task = params.require(:hint)[:task].to_i
    @hint = Hint.new(hint_params)
    respond_to do |format|
      if @hint.save
        if TaskHint.create(task_id: task, hint_id: @hint.id)
          format.html { redirect_to @hint, notice: 'Hint was successfully created.' }
          format.json { render action: 'show', status: :created, location: @hint }
        end
      else
        format.html { render action: 'new' }
        format.json { render json: @hint.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hints/1
  # PATCH/PUT /hints/1.json
  def update
    respond_to do |format|
      if @hint.update(hint_params)
        format.html { redirect_to @hint, notice: 'Hint was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @hint.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hints/1
  # DELETE /hints/1.json
  def destroy
    @hint.destroy
    respond_to do |format|
      format.html { redirect_to hints_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hint
      @hint = Hint.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
  def hint_params
    params.require(:hint).permit(:hint_text, :queue_number)
  end

  protected

    def check_task
      unless params.require(:task)
          redirect_to games_path
      end
      if Task.find(params.require(:task).to_i).game.state != 0
        redirect_to task_path(Task.find(params.require(:task).to_i)), notice: "You can't add new hints to tasks assigned with started or finished game"
      end

    end

    def check_task_create
      unless params.require(:hint)[:task]
        redirect_to tasks_path
      end
      task = params.require(:hint)[:task].to_i
      @task = Task.find(task)
      if params.require(:hint)[:queue_number].to_i <= 0
        redirect_to new_hint_path(task: @task.id), notice: "Parameter Queue number must be greater than 0"
      end
      if @task.hints.count > 0
        #if (@task.hints.count == 1)
        #  if @task.hints.first.queue_number == params.require(:hint)[:queue_number].to_i
        #    redirect_to new_hint_path(task: @task.id), notice: "Parameter Queue number must be greater than" +  params.require(:hint)[:queue_number]
        #  end
        #els
        if @task.hints.count >= 2
          redirect_to task_path(@task), notice: "Only two hints can be assigned with one task"
        end
      end
    end

    def no_hints
      unless Hint.all.count > 0
        redirect_to games_path
      end
    end

end
