class CollectionsController < ApplicationController
  before_action :set_collection, only: [:show, :edit, :update, :destroy, :embed, :player]

   after_filter :allow_iframe

 layout :resolve_layout

  # GET /collections
  # GET /collections.json
  def index
    @collections = Collection.all
    authorize User
  end

  # GET /collections/1
  # GET /collections/1.json
  def show
    @collection.views = @collection.views + 1
    @collection.save
  end

  def embed
    @collection.pieces.limit(12)
    @collection.views = @collection.views + 1
    @collection.save

    @collection.pieces.each do |piece|
      piece.views = piece.views.to_i + 1
      piece.save
    end
  end

  def player

  end

  # GET /collections/new
  def new
    @collection = Collection.new
  end

  # GET /collections/1/edit
  def edit
  end

  # POST /collections
  # POST /collections.json
  def create
    @collection = Collection.new(collection_params)
    @collection.user_id = current_user.id

    respond_to do |format|
      if @collection.save
        format.html { redirect_to @collection, notice: 'Collection was successfully created.' }
        format.json { render :show, status: :created, location: @collection }
      else
        format.html { render :new }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /collections/1
  # PATCH/PUT /collections/1.json
  def update
    respond_to do |format|
      if @collection.update(collection_params)
        format.html { redirect_to user_collection_path(:id => @collection.id, :slug => @collection.user.profile.slug), notice: 'Collection was successfully updated.' }
        format.json { render :show, status: :ok, location: @collection }
      else
        format.html { render :edit }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /collections/1
  # DELETE /collections/1.json
  def destroy
    @collection.destroy
    respond_to do |format|
      format.html { redirect_to collections_url, notice: 'Collection was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

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


    # Use callbacks to share common setup or constraints between actions.
    def set_collection
      @collection = Collection.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def collection_params
      params.require(:collection).permit(:title, :user_id, :slug, :views, :description)
    end
end
