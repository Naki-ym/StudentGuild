class PostsController < ApplicationController
  def timeline
    @post = Post.new
    @posts = Post.where(is_deleted: false).order(created_at: :desc)
  end
  def create
    @post = Post.new(content: params[:content], user_id: @current_user.id)
    if @post.save
      flash[:notice] = "投稿しました"
      redirect_to("/timeline")
    else
      @posts = Post.where(is_deleted: false).order(created_at: :desc)
      render("posts/timeline")
    end
  end
  def show
    @post = Post.find_by(id: params[:id])
    @user = User.find_by(id: @post.user_id)
  end
  def edit
    @post = Post.find_by(id: params[:id])
    @content = @post.content
  end
  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    if @post.save
      flash[:notice] = "変更を保存しました"
      redirect_to("/posts/#{@post.id}")
    else
      @content = @post.content
      render("users/edit")
    end
  end
  def delete
    @post = Post.find_by(id: params[:id])
    @post.is_deleted = true
    if @post.save
      flash[:notice] = "投稿を削除しました"
      redirect_to("/timeline")
    else
      currentpath = request.path_info
      if currentpath = "posts/timeline"
        @posts = Post.where(is_deleted: false).order(created_at: :desc)
        render("posts/timeline")
      else
        render("posts/show")
      end
    end
  end
end
