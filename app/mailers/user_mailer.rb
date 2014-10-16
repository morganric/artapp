class UserMailer < ActionMailer::Base
  default from: 'no-reply@herokuapp.com'

    def favourite_email(user, piece)
    @user = user
    @piece = piece
    @owner = piece.user
    @title = piece.title
    @url  = user_piece_path(:id => @piece.slug, :user_slug => piece.user.profile.slug)
    mail(to: @owner.email, subject: 'ArtUp Favourite')
  end
 end