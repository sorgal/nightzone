class UserGamesController < ApplicationController
  before_action :set_user_game, only: [:show, :edit, :update, :destroy]
  skip_before_filter :authorize_admin

  # GET /user_games
  # GET /user_games.json
  def index
    @user_games = UserGame.all
  end

  # GET /user_games/1
  # GET /user_games/1.json
  def show
  end

  # GET /user_games/new
  def new
    @user_game = UserGame.new
  end

  # GET /user_games/1/edit
  def edit
  end

  # POST /user_games
  # POST /user_games.json
  def create

    @user_game = UserGame.new(user_game_params)

    respond_to do |format|
      if @user_game.save
        format.html { redirect_to @user_game, notice: 'User game was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user_game }
      else
        format.html { render action: 'new' }
        format.json { render json: @user_game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_games/1
  # PATCH/PUT /user_games/1.json
  def update
    respond_to do |format|
      if @user_game.update(user_game_params)
        format.html { redirect_to @user_game, notice: 'User game was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user_game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_games/1
  # DELETE /user_games/1.json
  def destroy
    @user_game.destroy
    respond_to do |format|
      format.html { redirect_to user_games_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_game
      @user_game = UserGame.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_game_params
      params.require(:user_game).permit(:user_id, :game_id, :refuzed)
    end
end
