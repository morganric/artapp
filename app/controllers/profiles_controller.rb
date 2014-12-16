class ProfilesController < ApplicationController
  before_filter :authenticate_user!, except: [:show, :followers, :following, :embed]
  before_action :set_profile, only: [:show, :edit, :update, :destroy, :following, :followers, :embed, :shop]

 after_filter :allow_iframe

  layout :resolve_layout


  # GET /profiles
  # GET /profiles.json  
  def index
    @profiles = Profile.all
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    @pieces = Piece.where(:user_id => @profile.user.id).where(:hidden => false).page params[:page]
    @featured = Piece.where(:featured => true)
    @shop = @pieces.where(:sold => false ).where('price > ?', 0)
    @conversations = @profile.user.mailbox.inbox
    @receipts = []

    @conversations.limit(6).each do |convo|
      @receipts << convo.receipts_for(@profile.user)
    end
    return @receipts 

  end


   def message

    @user = User.find(params[:user_id])
    if @user.profile.inbox == true
         current_user.send_message(@user, params[:body], params[:subject])
    end
 
    
    respond_to do |format|
      format.html { redirect_to vanity_url_path(@user.profile.slug), notice: 'Sent.' }  
      format.js { redirect_to vanity_url_path(@user.profile.slug), notice: 'Sent.' }
    end

  end


  def embed
    @pieces = Piece.where(:user_id => @profile.user.id).where(:hidden => false).order('created_at DESC')
    @featured = Piece.where(:featured => true)

    @pieces.each do |piece|
      piece.views = piece.views.to_i + 1
      piece.save
    end
    
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
  end

  # GET /profiles/1/edit
  def edit
  end

  def following
    @title = "Following"
    @user  = @profile.user
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = @profile.user
    @users = @user.followers
    render 'show_follow'
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(profile_params)

    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

     def resolve_layout
    case action_name
    when "embed", "player"
      "embed"
    else
      "paper"
    end
  end

  
  def allow_iframe
    response.headers["X-Frame-Options"] = "GOFORIT"
  end


    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:display_name, :user_id, :bio,
      :twitter, :banner, :image, :dob, :location, :slug, :website, :notifications, :donations, :inbox)
    end
end
