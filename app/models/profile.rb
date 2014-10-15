class Profile < ActiveRecord::Base
    mount_uploader :image, ImageUploader
    mount_uploader :banner, ImageUploader

	belongs_to :user

	extend FriendlyId
  	friendly_id :user_name, use: [:slugged, :finders]

  	protected

	  def user_name
	    user.name
	  end

end
