class PiecesController < ApplicationController
  before_filter :authenticate_user!, except: [:show, :index, :tag, :featured, :categories, :tag_embed]
  before_action :set_piece, only: [:show, :edit, :update, :destroy, :nope, :dope, :upload_email, :embed, :loved_by]
  after_action :upload_email, only: :create


 after_filter :allow_iframe

 layout :resolve_layout

  # GET /pieces
  # GET /pieces.json
  def index

    @now = Date.today - 28
    @pieces = Piece.where(:hidden => false).where('created_at > ?', @now ).order('views DESC').page params[:page]
    @new_pieces = Piece.where(:hidden => false).order('created_at DESC').page params[:page]
    @tags = Piece.tag_counts_on(:tags).order("taggings_count DESC")

    @for_sale = Piece.where(:hidden => false).where(:sold => false).where("price > ?", 10).order('views DESC').page params[:page]
    @collections = Collection.all.order('views DESC')
  end

  # def facebook
  #     @pieces = Piece.where(:hidden => false).order('views DESC').page params[:page]
  #   @new_pieces = Piece.where(:hidden => false).order('created_at DESC').page params[:page]
  #   @tags = Piece.tag_counts_on(:tags)
  # end

  def categories
    @tags = Piece.tag_counts_on(:tags).order("taggings_count DESC").limit(6)
  end 


  def featured
    @pieces = Piece.where(:hidden => false).where(:featured => true).order('created_at DESC').page params[:page]
    
  end

  def tag
    @pieces = Piece.where(:hidden => false).tagged_with(params[:tag]).order('views DESC').page params[:page]
    @new_pieces = Piece.where(:hidden => false).tagged_with(params[:tag]).order('created_at DESC').page params[:page]
    @for_sale = Piece.where(:hidden => false).tagged_with(params[:tag]).where(:sold => false).where("price > ?", 10).order('views DESC').page params[:page]
    @collections = Collection.all.order('views DESC')
    @tags = Piece.tag_counts_on(:tags)
    @tag = params[:tag]
    # render :action => 'index'
  end

  def tag_embed
    @pieces = Piece.where(:hidden => false).tagged_with(params[:tag]).order('views DESC').limit(12)
    @tag = params[:tag]

     @pieces.each do |piece|
      piece.views = piece.views.to_i + 1
      piece.save
    end
    
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

  def loved_by
  end

  def embed

    @piece.views = @piece.views.to_i + 1
    @piece.save

    if @piece.hidden == true
        redirect_to vanity_url_path(@piece.user.profile), notice: 'Sorry no peaking, this piece is hidden.'
      end
    
    respond_to do |format|
      format.js
      format.html
    end 
  end

   def oembed
        # get project ID
        url = params[:url].split("/")
        piece_id = url[4]

        @project = @piece = Piece.friendly.find(piece_id)
        html = render_to_string :partial => "pieces/oembed", :formats => [:html], :locals => { :piece => @piece }

        oembed_response = {}
        # here's the problem:
        oembed_response["type"] = "rich"
        oembed_response["version"] = "1.0"
        oembed_response["title"] = @piece.title
        oembed_response["html"] = html

        respond_to do | format |
            if(@piece)
                format.html { render :text => "Test" }
                format.json { render json: oembed_response, status: :ok }
                format.xml { render xml: oembed_response, status: :ok }
            else
                # error
            end
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
    when "embed", "tag_embed"
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
