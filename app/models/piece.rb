class Piece < ActiveRecord::Base
	acts_as_votable
	acts_as_taggable
	paginates_per 12

	mount_uploader :image, ImageUploader

	validate :maximum_amount_of_tags
	validates_uniqueness_of :title, :presence => true
	
	def maximum_amount_of_tags
	number_of_tags = tag_list_cache_on("tags").uniq.length
	errors.add(:base, "Please only add 5 tags") if number_of_tags > 5
	end

	belongs_to :user

	has_many :user_favs
    has_many :favourited_by, :through => :user_favs, :source => :user

    has_many :collection_pieces
	has_many :collections, :through => :collection_pieces, :source => :collection

	extend FriendlyId
	  friendly_id :title, use: :slugged

end
