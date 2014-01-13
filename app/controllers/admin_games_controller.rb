class AdminGamesController < ApplicationController
  before_action :set_admin_game, only: [:show, :edit, :update, :destroy]

  # GET /admin_games
  # GET /admin_games.json
  def index
    @admin_games = AdminGame.all
  end

  # GET /admin_games/1
  # GET /admin_games/1.json
  def show
  end

  # GET /admin_games/new
  def new
    @admin_game = AdminGame.new
  end

  # GET /admin_games/1/edit
  def edit
  end

  # POST /admin_games
  # POST /admin_games.json
  def create
    @admin_game = AdminGame.new(admin_game_params)

    respond_to do |format|
      if @admin_game.save
        format.html { redirect_to @admin_game, notice: 'Admin game was successfully created.' }
        format.json { render action: 'show', status: :created, location: @admin_game }
      else
        format.html { render action: 'new' }
        format.json { render json: @admin_game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin_games/1
  # PATCH/PUT /admin_games/1.json
  def update
    respond_to do |format|
      if @admin_game.update(admin_game_params)
        format.html { redirect_to @admin_game, notice: 'Admin game was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @admin_game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_games/1
  # DELETE /admin_games/1.json
  def destroy
    @admin_game.destroy
    respond_to do |format|
      format.html { redirect_to admin_games_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_game
      @admin_game = AdminGame.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_game_params
      params.require(:admin_game).permit(:admin_id, :game_id)
    end
end
