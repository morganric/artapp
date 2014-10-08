class Piece < ActiveRecord::Base
	acts_as_taggable
	paginates_per 10

	mount_uploader :image, ImageUploader

	belongs_to :user

	extend FriendlyId
	  friendly_id :title, use: :slugged

end
