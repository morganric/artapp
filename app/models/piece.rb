class Piece < ActiveRecord::Base
	acts_as_taggable

	mount_uploader :image, ImageUploader

	belongs_to :user

	extend FriendlyId
	  friendly_id :title, use: :slugged

end
