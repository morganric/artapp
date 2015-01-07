class SearchController < ActionController::Base

layout 'paper'

def index

	if params[:q]
	@pieces = Piece.where(:title => params[:q])
	@profiles = Profile.where(:display_name => params[:q])
	else
		@pieces = []
		@profiles = []
	end

end
  
end
