module CategoriesHelper

	def pieces(category)
		@category = category
		pieces = []
		@category.users.each do |user|
			pieces << user.pieces.last
		end

		return pieces.sort.reverse
	end
end
