class RelationshipsController < ApplicationController
  before_filter :authenticate_user!, except: [:create, :destroy]

  def create
    user = User.find(params[:followed_id])
    current_user.follow(user)
    redirect_to vanity_url_path(user.profile)
  end

  def destroy
    user = Relationship.find(params[:id]).followed
    current_user.unfollow(user)
    redirect_to vanity_url_path(user.profile)
  end
end