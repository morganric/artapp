class PiecesController < ApplicationController
  before_filter :authenticate_user!, except: [:show, :index, :tag, :featured]
  before_action :set_piece, only: [:show, :edit, :update, :destroy, :nope, :dope, :upload_email, :embed]
  after_action :upload_email, only: :create


 after_filter :allow_iframe

 layout :resolve_layout

  # GET /pieces
  # GET /pieces.json
  def index
    @pieces = Piece.where(:hidden => false).order('views DESC').page params[:page]
    @new_pieces = Piece.where(:hidden => false).order('created_at DESC').page params[:page]
    @tags = Piece.tag_counts_on(:tags).order("taggings_count DESC")
  end

  # def facebook
  #     @pieces = Piece.where(:hidden => false).order('views DESC').page params[:page]
  #   @new_pieces = Piece.where(:hidden => false).order('created_at DESC').page params[:page]
  #   @tags = Piece.tag_counts_on(:tags)
  # end

  def categories
    @tags = Piece.tag_counts_on(:tags).order("taggings_count DESC")
  end 


  def featured
    @pieces = Piece.where(:hidden => false).where(:featured => true).order('created_at DESC').page params[:page]
    
  end

  def tag
    @pieces = Piece.where(:hidden => false).tagged_with(params[:tag]).order('views DESC').page params[:page]
    @new_pieces = Piece.where(:hidden => false).tagged_with(params[:tag]).order('created_at DESC').page params[:page]
    

    @tags = Piece.tag_counts_on(:tags)
    render :action => 'index'
  end

  def dope
    @piece.liked_by current_user
  end

  def nope
    @piece.downvote_from current_user
  end

  # GET /pieces/1
  # GET /pieces/1.json
  def show
    @piece.views = @piece.views.to_i + 1
    @piece.save

    if @piece.hidden == true
      redirect_to vanity_url_path(@piece.user.profile), notice: 'Sorry no peaking, this piece is hidden.'
    end
  end

  def embed

    @piece.views = @piece.views.to_i + 1
    @piece.save

    if @piece.hidden == true
      redirect_to vanity_url_path(@piece.user.profile), notice: 'Sorry no peaking, this piece is hidden.'
    end
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
    @piece.hidden = false
    @piece.featured = false

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


  def resolve_layout
    case action_name
    when "embed"
      "embed"
    else
      "paper"
    end
  end


  def allow_iframe
    response.headers["X-Frame-Options"] = "GOFORIT"
  end

    def upload_email
      @followers = current_user.followers
      @followers.each do |follower|
        UserMailer.upload_email(current_user, follower, @piece).deliver
      end

      # @admins = User.where(:role => 2)

      # @admins.each do |admin|
      #   UserMailer.admin_email(current_user, admin, @piece).deliver
      # end
    end


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
