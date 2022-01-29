class FavoritesController < ApplicationController
  before_action :post_params
  def create
    Favorite.create(user_id: @current_user.id, post_id: params[:id])
  end

  def delete
    @favorite = Favorite.find_by(user_id: @current_user.id, post_id: params[:id], delete_flg: false)
    @favorite.delete_flg = true
    @favorite.save
  end

  private

  def post_params
    @post = Post.find_by(id: params[:id], delete_flg: false)
  end 
end
