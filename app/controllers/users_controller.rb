class UsersController < ApplicationController
  #ログインしていないユーザーがアクセスできない
  before_action :authenticate_user, {only: [:edit, :update, :logout, :delete, :settings, :follows, :followers]}
  #ログインしているユーザーがアクセスできない
  before_action :forbid_login_user, {only: [:signup, :create, :login_form, :login]}

  def signup
  end
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice]    = "ユーザー登録が完了しました"
      redirect_to("/users/#{@user.id}")
    else
      render("signup")
    end
  end
  def login_form
  end
  def login
    @user = User.find_by(email: params[:email], is_deleted: false)
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice]    = "ログインしました"
      redirect_to("/users/#{@user.id}/")
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email         = params[:email]
      render("users/login_form")
    end
  end
  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login")
  end
  def show
    @user            = User.find_by(id: params[:id])
    @posts           = Post.where(user_id: @user.id, is_deleted: false)
    @following_users = @user.following_user
    @follower_users  = @user.follower_user
    @roomusers       = RoomUser.where(user_id: @current_user, is_deleted: false)
    @room            = nil
    @roomusers.each do |roomuser|
      @my_roomusers = RoomUser.find_by(room_id: roomuser.room_id, user_id:@user.id, is_deleted: false)
      if @my_roomusers
        @room = Room.find_by(id: @my_roomusers.room_id, is_group_chat: false, is_deleted: false)
      end
    end
  end
  def edit
    @user  = User.find_by(id: params[:id])
    @name  = @user.name
    @email = @user.email
  end
  def update
    @user = User.find_by(id: params[:id])
    if @user.update(user_params)
      flash[:notice] = "変更を保存しました"
      redirect_to("/users/#{@user.id}/")
    else
      @name  = @user.name
      @email = @user.email
      render("users/edit")
    end
  end
  def delete
    @user      = User.find_by(id: params[:id])
    @posts     = Post.where(user_id: @user.id)
    @favorites = Favorite.where(user_id: @user.id)
    @favorites.each do |favorite|
      favorite.is_deleted = true
      favorite.save
    end
    @posts.each do |post|
      @favorites = Favorite.where(post_id: post.id)
      @favorites.each do |favorite|
        favorite.is_deleted = true
        favorite.save
      end
      post.is_deleted = true
      post.save
    end
    @user.is_deleted = true
    if @user.save
      session[:user_id] = nil
      flash[:notice]    = "ユーザーを削除しました"
      redirect_to("/login")
    else
      @error_message = "削除に失敗しました"
      render("users/#{@user.id}")
    end
  end
  def settings
  end

  def follows
    user   = User.find(params[:id])
    @users = user.following_user.reverse_order
  end
  
  def followers
    user   = User.find(params[:id])
    @users = user.follower_user.reverse_order
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :icon, :icon_cache)
  end
end
