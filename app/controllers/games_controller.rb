class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy, :start_game]
  skip_before_filter :authorize_admin, only: [:index, :show]

  # GET /games
  # GET /games.json
  def index
    @games = Game.where(state: 0)
  end

  # GET /games/1
  # GET /games/1.json
  def show
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
        if AdminGame.create(admin_id: current_admin_user.id, game_id: @game.id)
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
      params.require(:game).permit(:title, :start_date, :duration)
    end

  public

    def start_game
      @game.update(state: 1)
      @user_games = UserGame.where(game_id: @game.id)
      @game_tasks = GameTask.where(game_id: @game.id).first
      @user_games.each do |user_game|
        @user_tasks.create(user_id: @user_game.id, task_id: @game_tasks.first.task_id, result: 0)
      end
      redirect_to games_path
    end

end
