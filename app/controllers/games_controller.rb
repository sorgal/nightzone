class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy, :start_game, :check_game_status, :finish_game, :check_task_and_game, :check_started]
  skip_before_filter :authorize_admin, only: [:index, :show]
  before_filter :authenticate_admin_or_user, only: [:show]
  before_filter :check_game_status, only: [:show]
  before_filter :check_tasks_and_game, only: [:start_game]
  before_filter :check_started, only: [:finish_game]

  # GET /games
  # GET /games.json
  def index
    @games = Game.all
  end

  # GET /games/1
  # GET /games/1.json
  def show
    @status = ""
    if @game.state == 0
      @status = "Wait"
    elsif @game.state > 0
      @status = "Started"
      if user_signed_in?
        @user_game = current_user.user_games.where(game_id: @game.id).first
        @task = current_user.tasks.last
        @arr = @game.get_task_codes_count(@task, current_user)
        @code_compares_count = @arr[0]
        @task_codes_count = @arr[1]
      end
    elsif @game.state < 0
      @status = "Finished"
    end
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  # POST /games.json
  def create
    game = game_params
    game[:start_date] = game[:start_date].to_datetime
    @game = Game.new(game)

    respond_to do |format|
      if @game.save
        if AdminGame.create(admin_user_id: current_admin_user.id, game_id: @game.id)
          format.html { redirect_to @game, notice: 'Game was successfully created.' }
          format.json { render action: 'show', status: :created, location: @game }
        end
      else
        format.html { render action: 'new' }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:title, :start_date)
    end

  public
    #Заглушки для отложенных задач
    def start_game
      @game.start_game
      redirect_to game_path(@game), notice: "Game was started"
    end

    def finish_game
      @game.finish_game
      redirect_to game_path(@game), notice: "Game was finished"
    end

  protected

  def check_game_status
    if user_signed_in? && @game.state <= 0
      redirect_to root_path
    end
  end

  def authenticate_admin_or_user
    unless user_signed_in? || current_admin_user
      redirect_to root_path
    end
  end

  def check_tasks_and_game
    if @game.tasks.count == 0
      redirect_to game_path(@game.id), notice: "You can't start game without tasks"
    elsif @game.state == UserGame::CURRENT
      redirect_to game_path(@game.id), notice: "This game was already started"
    elsif @game.state == UserGame::COMPLETED
      redirect_to game_path(@game.id), notice: "This game was already finished"
    else
      tasks = @game.tasks
      tasks.each do |task|
        if task.codes.count == 0
          redirect_to game_path(@game.id), notice: "You can't start game without codes for game's tasks"
          break
        end
      end
    end
  end

  def check_started
    if @game.state == 0
      redirect_to game_path(@game.id), notice: "You can't finish this game, because it was not started "
    elsif @game.state < 0
      redirect_to game_path(@game.id), notice: "You can't finish this game, because it was finished already "
    end
  end

end
