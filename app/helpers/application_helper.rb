module ApplicationHelper
  def url_with_protocol(url)
    /^http/i.match(url) ? url : "http://#{url}"
  end

  
	def pieces(category)
		@category = category
		pieces = []
		@category.users.each do |user|
			pieces << user.pieces.last
		end

		return pieces.sort.reverse
	end
end
