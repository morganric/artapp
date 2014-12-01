class UserMailer < ActionMailer::Base
  default from: 'no-reply@artup.io'

    def favourite_email(user, piece)
    @user = user
    @piece = piece
    @owner = piece.user
    @title = piece.title
    @url  = user_piece_path(:id => @piece.slug, :user_slug => piece.user.profile.slug)
    if check_notifications(@owner)
    mail(to: @owner.email, subject: 'ArtUp Favourite')
    end
  end

  def collection_email(user, piece, collection)
    @user = user
    @piece = piece
    @owner = piece.user
    @title = piece.title
    @collection = collection
    @url  = user_collection_url(:id => @collection.id, :slug => piece.user.profile.slug)
    if check_notifications(@owner)
      mail(to: @owner.email, subject: 'ArtUp New Collection')
    end
  end


  def follower_email(followed, follower)
    @followed = followed
    @follower = follower
    @url  = vanity_url_path(@follower.profile.slug)
    if check_notifications(@followed)
    mail(to: @followed.email, subject: 'New ArtUp Follower')
    end
  end

  def upload_email(uploader, follower, piece)
    @uploader = uploader
    @piece = piece
    @follower = follower
    @title = piece.title
    @url  = user_piece_path(:id => @piece.slug, :user_slug => @piece.user.profile.slug)
    if check_notifications(@follower)
      mail(to: @follower.email, subject: 'New ArtUp Piece')
    end
  end 

   private
    # Use callbacks to share common setup or constraints between actions.
    def check_notifications(user)
      return user.profile.notifications
    end


 end