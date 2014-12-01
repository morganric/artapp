class CollectionPiecesController < ApplicationController


	# after_action :fav_email, only: :create


	def create
		@collection_piece = CollectionPiece.create(collection_piece_params)

		respond_to do |format|
	      if @collection_piece.save
	        format.js { redirect_to :back, notice: 'Collection was successfully created.' }
	      else
	        format.js { redirect_to :back, notice: 'Collection was not successfully created.' }
	      end
	    end
	end

	def destroy
		@collection_piece = CollectionPiece.where(collection_piece_params)
		respond_to do |format|
	      if @collection_piece.first.destroy
	        format.js { redirect_to :back, notice: 'Collection was successfully destroyed.' }
	      else
	        format.js { redirect_to :back, notice: 'Collection was not successfully destroyed.' }
	      end
	    end
	end

	# def fav_email
	# 	@profile = current_user.profile
	# 	@piece = Piece.find(params[:user_fav][:piece_id])
	# 	UserMailer.favourite_email(@profile.user, @piece).deliver
	# end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def collection_piece_params
      params.require(:collection_piece).permit(:piece_id, :collection_id)
    end



end
