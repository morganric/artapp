class UserMailer < ActionMailer::Base
  default from: 'no-reply@artup.io'

  def favourite_email(user, piece)
    @user = user
    @piece = piece
    @owner = piece.user
    @title = piece.title
    @url  = user_piece_path(:id => @piece.slug, :user_slug => piece.user.profile.slug)
    mail(to: @owner.email, subject: 'ArtUp Favourite')
  end

  def order_email(email, piece)
    @email = email
    @piece = piece
    @url  = user_piece_path(:id => @piece.slug, :user_slug => @piece.user.profile.slug)
    mail(to: @email, subject: 'ArtUp Order')
  end

  def sale_email(piece, email)
    @email = email
    @piece = piece
    @url  = user_piece_path(:id => @piece.slug, :user_slug => @piece.user.profile.slug)
    mail(to: @piece.user.email, subject: 'Congratulations: New ArtUp Sale')
  end



  def follower_email(followed, follower)
    @followed = followed
    @follower = follower
    @url  = vanity_url_path(@follower.profile.slug)
    mail(to: @followed.email, subject: 'New ArtUp Follower')
  end

  def upload_email(uploader, follower, piece)
    @uploader = uploader
    @piece = piece
    @follower = follower
    @title = piece.title
    @url  = user_piece_path(:id => @piece.slug, :user_slug => @piece.user.profile.slug)
    mail(to: @follower.email, subject: 'New ArtUp Piece')
  end 


 end