class RelationshipsController < ApplicationController
  #ログインしていないユーザーがアクセスできない
  before_action :authenticate_user

  def create
    @user = User.find_by(id: params[:id])
    @following_users = @user.following_user
    @follower_users  = @user.follower_user
    @current_user.follow(params[:id])
  end
  
  def destroy
    @user = User.find_by(id: params[:id])
    @following_users = @user.following_user
    @follower_users  = @user.follower_user
    @current_user.unfollow(params[:id])
  end
end
