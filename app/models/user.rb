class User < ActiveRecord::Base
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?
  after_create :create_profile

  validates_exclusion_of :name, :in => %w( facebook message discussions facebook tedx featured users feeds photos videos items admin oembed api facebook new popular featured favicon superuser 
    pages partners categories category creators platforms media posts authors types providers tagged ), :message => "You don't belong here"


  def set_default_role
    self.role ||= :user
  end

  def create_profile
    @profile = Profile.new(:user_id => id)
    @profile.save
  end


  # Follows a user.
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  # Unfollows a user.
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :pieces
  has_one :profile

   has_many :user_favs
  has_many :favourites, :through => :user_favs, :source => :piece

  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
   has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
end
