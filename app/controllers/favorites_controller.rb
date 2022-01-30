class FavoritesController < ApplicationController
  before_action :post_params
  def create
    Favorite.create(user_id: @current_user.id, post_id: params[:id])
  end

  def delete
    @favorite = Favorite.find_by(user_id: @current_user.id, post_id: params[:id], is_deleted: false)
    @favorite.is_deleted = true
    @favorite.save
  end

  private

  def post_params
    @post = Post.find_by(id: params[:id], is_deleted: false)
  end 
end
