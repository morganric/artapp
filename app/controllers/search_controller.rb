class SearchController < ActionController::Base

layout 'paper'

def index

	if params[:q]
	@pieces = Piece.where(:title => params[:q]).limit(10)
	@profiles = Profile.where(:display_name => params[:q]).limit(10)
	else
		@pieces = []
		@profiles = []
	end

end
  
end
