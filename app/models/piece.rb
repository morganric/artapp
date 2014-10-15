class Piece < ActiveRecord::Base
	acts_as_taggable
	paginates_per 10

	mount_uploader :image, ImageUploader

	validate :maximum_amount_of_tags
	
	def maximum_amount_of_tags
	number_of_tags = tag_list_cache_on("tags").uniq.length
	errors.add(:base, "Please only add 5 tags") if number_of_tags > 5
	end

	belongs_to :user

	extend FriendlyId
	  friendly_id :title, use: :slugged

end
