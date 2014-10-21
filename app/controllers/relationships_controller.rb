class RelationshipsController < ApplicationController
  before_filter :authenticate_user!, except: [:create, :destroy]
  after_action :follow_email, only: :create

  def create
    user = User.find(params[:followed_id])
    current_user.follow(user)
    redirect_to :back
  end

  def destroy
    user = Relationship.find(params[:id]).followed
    current_user.unfollow(user)
    redirect_to :back
  end


  def follow_email
    @follower = current_user
    @followed = User.find(params[:followed_id])
    UserMailer.follower_email(@followed, @follower).deliver
  end
end