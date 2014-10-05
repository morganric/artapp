class PiecesController < ApplicationController
  before_filter :authenticate_user!, except: [:show, :index, :tag, :featured]
  before_action :set_piece, only: [:show, :edit, :update, :destroy]

  # GET /pieces
  # GET /pieces.json
  def index
    @pieces = Piece.where(:hidden => false).order('views DESC')
  end

  def featured
    @pieces = Piece.where(:hidden => false).where(:featured => true).limit(6)
    
  end

  def tag
    @pieces = Piece.where(:hidden => false).tagged_with(params[:tag]).page(params[:all])

    @tags = Piece.tag_counts_on(:tags)
    render :action => 'index'
  end

  # GET /pieces/1
  # GET /pieces/1.json
  def show
    @piece.views = @piece.views.to_i + 1
    @piece.save
  end

  # GET /pieces/new
  def new
    @piece = Piece.new
  end

  # GET /pieces/1/edit
  def edit
  end


  # POST /pieces
  # POST /pieces.json
  def create
    @piece = Piece.new(piece_params)
    @piece.user_id = current_user.id

    respond_to do |format|
      if @piece.save
        format.html { redirect_to @piece, notice: 'Piece was successfully created.' }
        format.json { render :show, status: :created, location: @piece }
      else
        format.html { render :new }
        format.json { render json: @piece.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pieces/1
  # PATCH/PUT /pieces/1.json
  def update
    respond_to do |format|
      if @piece.update(piece_params)
        format.html { redirect_to @piece, notice: 'Piece was successfully updated.' }
        format.json { render :show, status: :ok, location: @piece }
      else
        format.html { render :edit }
        format.json { render json: @piece.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pieces/1
  # DELETE /pieces/1.json
  def destroy
    @piece.destroy
    respond_to do |format|
      format.html { redirect_to pieces_url, notice: 'Piece was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_piece
      @piece = Piece.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def piece_params
      params.require(:piece).permit(:title, :image, :description, :tag_list,
       :dimensions, :views, :user_id, :price, :slug, :sold, :hidden, :featured)
    end
end
