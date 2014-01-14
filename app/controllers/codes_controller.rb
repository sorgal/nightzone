class CodesController < ApplicationController
  before_action :set_code, only: [:show, :edit, :update, :destroy]
  before_filter :check_game, only: [:new]
  before_filter :check_game_create, only: [:create]
  before_filter :no_codes, except: [:new, :create]

  # GET /codes
  # GET /codes.json
  def index
    @codes = Code.all
  end

  # GET /codes/1
  # GET /codes/1.json
  def show
  end

  # GET /codes/new
  def new
    @code = Code.new
  end

  # GET /codes/1/edit
  def edit
  end

  # POST /codes
  # POST /codes.json
  def create
    @code = Code.new(code_params)
    game = params.require(:code)[:game].to_i
    respond_to do |format|
      if @code.save
        if GameCode.create(game_id: game, code_id: @code.id)
          format.html { redirect_to @code, notice: 'Code was successfully created.' }
          format.json { render action: 'show', status: :created, location: @code }
        end
      else
        format.html { render action: 'new' }
        format.json { render json: @code.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /codes/1
  # PATCH/PUT /codes/1.json
  def update
    respond_to do |format|
      if @code.update(code_params)
        format.html { redirect_to @code, notice: 'Code was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @code.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /codes/1
  # DELETE /codes/1.json
  def destroy
    @code.destroy
    respond_to do |format|
      format.html { redirect_to codes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_code
      @code = Code.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def code_params
      params.require(:code).permit(:code_string)
    end

  protected

    def check_game
      unless params.require(:game)
        redirect_to games_path
      end
    end

    def check_game_create
      unless params.require(:code)
        redirect_to games_path
      end
    end

    def no_codes
      unless Code.all.count > 0
        redirect_to games_path
      end
    end
end
