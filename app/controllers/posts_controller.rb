class PostsController < ApplicationController
  #ログインしていないユーザーがアクセスできない
  before_action :authenticate_user

  def timeline
    @post  = Post.new
    case params[:search]
    when nil
      @followings_id = []
      @current_user.followings.each do |user|
        @followings_id << user.id
      end
      @posts = Post.kept.where(user_id: @followings_id).order(created_at: :desc)
    when "all"
      @posts = Post.kept.order(created_at: :desc)
    else
      @posts = Post.kept.order(created_at: :desc)
    end
  end
  def create
    @post = Post.new(post_params)

    if @post.save
      flash[:notice] = "投稿しました"
      redirect_to("/timeline")
    else
      @posts = Post.kept.where(user_id: @followings_id).order(created_at: :desc)
      render("posts/timeline")
    end
  end
  def show
    @post = Post.find_by(id: params[:id])
    @user = User.find_by(id: @post.user_id)
  end
  def edit
    @post    = Post.find_by(id: params[:id])
    @content = @post.content
  end
  def update
    @post = Post.find_by(id: params[:id])

    if @post.update(post_params)
      flash[:notice] = "変更を保存しました"
      redirect_to("/posts/#{@post.id}")
    else
      @content = @post.content
      render("users/edit")
    end
  end
  def delete
    @post      = Post.find_by(id: params[:id])
    @favorites = Favorite.where(post_id: @post.id)
    
    @favorites.each do |favorite|
      favorite.destroy
    end
    if @post.discard
      flash[:notice] = "投稿を削除しました"
      redirect_to("/timeline")
    else
      currentpath = request.path_info
      if currentpath == "posts/timeline"
        @posts = Post.kept.order(created_at: :desc)
        render("posts/timeline")
      else
        render("posts/show")
      end
    end
  end

  private
  def post_params
    params.require(:post).permit(:content).merge(user_id: @current_user.id)
  end
end
