class VisitorsController < ApplicationController

def index
	@featured = Piece.where(:featured => true)
end

end
