class Piece < ActiveRecord::Base

	mount_uploader :image, ImageUploader

	belongs_to :user

	extend FriendlyId
	  friendly_id :title, use: :slugged

end
