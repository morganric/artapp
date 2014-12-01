class Collection < ActiveRecord::Base

extend FriendlyId
  friendly_id :title, use: :slugged

belongs_to :user

has_many :collection_pieces
has_many :pieces, :through => :collection_pieces, :source => :piece

end
