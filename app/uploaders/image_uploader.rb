# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  include Cloudinary::CarrierWave

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  # storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :thumb do
    process :resize_to_fill => [50, 50]
  end

  version :small do
    process :resize_to_fill => [100, 100]
  end

  version :mini do
    process :resize_to_fill => [280, 150]
  end

  version :embed do
    process :resize_to_fit => [500, 500]
    cloudinary_transformation :transformation =>[
        {:width=>500, :height=>500,  :crop=>:fill}, {  :overlay => "tosuhfxnwvtfojrgtf23.png", 
             :gravity => :south_west, :x => 5, :y => 5, :width => 50, :radius => 10 }]
  end

  version :profile do
    process :resize_to_fill => [150, 150]
  end

   version :square do
    process :resize_to_fill => [350, 350]
  end

   version :featured do
    process :resize_to_fill => [350, 60]
  end

   version :piece do
    process :resize_to_fit => [650, 800]
  end

   version :collection do
    process :resize_to_fill => [1500, 800]
    cloudinary_transformation :transformation =>[
        {:width=>1500, :height=>800,  :crop=>:fill}, {  :overlay => "tosuhfxnwvtfojrgtf23.png", 
              :gravity => :south_west, :x => 5, :y => 5, :width => 100, :radius => 10 }]
  end

   version :banner do
    process :resize_to_fill => [1500, 300]
  end

  version :back do
    process :resize_to_fill => [1200, 1200]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
