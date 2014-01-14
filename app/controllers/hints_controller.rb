class HintsController < ApplicationController
  before_filter :check_game, only: [:new]
  before_filter :check_game_create, only: [:create]
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
    @hint = Hint.new
    @game = params[:game]
  end

  # GET /hints/1/edit
  def edit
  end

  # POST /hints
  # POST /hints.json
  def create
    @hint = Hint.new(hint_params)
    game = params.require(:hint)[:game].to_i
    respond_to do |format|
      if @hint.save
        if GameHint.create(game_id: game, hint_id: @hint.id)
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

    def check_game
      unless params.require(:game)
          redirect_to games_path
      end
    end

    def check_game_create
      unless params.require(:hint)
        redirect_to games_path
      end
    end

    def no_hints
      unless Hint.all.count > 0
        redirect_to games_path
      end
    end

end
