class HintsController < ApplicationController
  before_filter :check_task, only: [:new]
  before_filter :check_task_create, only: [:create]
  before_filter :no_hints, except: [:new, :create]
  before_action :set_hint, only: [:show, :edit, :update, :destroy]
  skip_before_filter :authorize_admin, only: [:show]

  # GET /hints
  # GET /hints.json
  def index
    @hints = Hint.all
  end

  # GET /hints/1
  # GET /hints/1.json
  def show
  end

  # GET /hints/new
  def new
    task = params[:task].to_i
    @cant_add = false
    if TaskHint.where(task_id: task).count == 2
      @cant_add = true
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
    end

    def check_task_create
      unless params.require(:hint)[:task]
        redirect_to games_path
      end
      task = params.require(:hint)[:task].to_i
      @task_hints = TaskHint.where(task_id: task)
      if @task_hints.count > 0
        @hint = Hint.find(@task_hints.first.hint_id)
        if @hint.queue_number == params.require(:hint)[:queue_number].to_i
          redirect_to new_hint_path, notice: "Parameter queue_number must be equal to " +  (3 - params.require(:hint)[:queue_number].to_i).to_s
        end
      end
    end

    def no_hints
      unless Hint.all.count > 0
        redirect_to games_path
      end
    end

end
