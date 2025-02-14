class UsersController < ApplicationController
  #ログインしていないユーザーがアクセスできない
  before_action :authenticate_user, {except: [:signup, :create, :login_form, :login]}
  #ログインしているユーザーがアクセスできない
  before_action :forbid_login_user, {only: [:signup, :create, :login_form, :login]}
  #管理者アカウントのみがアクセスできる
  before_action :admin_user, {only: [:admin_settings]}

  def signup
  end

  def create
    @user = User.new(user_params)
    @user.icon = "icon.png"

    if User.kept.where(email: user_params["email"]).empty?
      if @user.save
        if @user.id == 1
          @user.admin = true
          @user.save
        end
        session[:user_id] = @user.id
        flash[:notice]    = "ユーザー登録が完了しました"
        redirect_to("/users/#{@user.id}")
      else
        render("signup")
      end
    else
      @error_message = "このメールアドレスはすでに使用されています"
      render("signup")
    end
  end

  def login_form
  end

  def login
    @user = User.kept.find_by(email: params[:email])

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
    flash[:notice]    = "ログアウトしました"
    redirect_to("/login")
  end

  def show
    @user            = User.kept.find_by(id: params[:id])
    @posts           = Post.kept.where(user_id: @user.id).order(created_at: :desc)
    @following_users = @user.following_user
    @follower_users  = @user.follower_user
    @roomusers       = RoomUser.kept.where(user_id: @current_user)
    @room            = nil

    @roomusers.each do |roomuser|
      @my_roomusers = RoomUser.kept.find_by(room_id: roomuser.room_id, user_id:@user.id)
      if @my_roomusers
        @room = Room.kept.find_by(id: @my_roomusers.room_id, is_group_chat: false)
      end
    end
  end

  def edit
    @user  = User.kept.find_by(id: params[:id])
    @name  = @user.name
    @email = @user.email
  end

  def edit_password
    @user  = User.kept.find_by(id: params[:id])
    @name  = @user.name
    @email = @user.email
  end

  def update
    @user = User.kept.find_by(id: params[:id])
    if @user.update(user_params)
      flash[:notice] = "変更を保存しました"
      redirect_to("/users/#{@user.id}/")
    else
      @name  = @user.name
      render("users/edit")
    end
  end

  def update_password
    @user = User.kept.find_by(id: params[:id])
    if @user.authenticate(password_params["old_password"])
      if password_params["password"] == password_params["password_check"]
        if @user.update(password: password_params["password"])
          flash[:notice] = "変更を保存しました"
          redirect_to("/users/#{@user.id}/")
        else
          @error_message = "変更に失敗しました"
          render("users/edit_password")
        end
      else
        @error_message = "新しいパスワードと確認用の新しいパスワードが異なります"
        render("users/edit_password")
      end
    else
      @error_message = "現在のパスワードが正しくありません"
      render("users/edit_password")
    end
  end

  def delete
    @user      = User.kept.find_by(id: params[:id])
    @posts     = Post.kept.where(user_id: @user.id)
    @favorites = Favorite.where(user_id: @user.id)
    @favorites.each do |favorite|
      favorite.destroy
    end
    @posts.each do |post|
      @favorites = Favorite.where(post_id: post.id)
      @favorites.each do |favorite|
        favorite.destroy
      end
      post.discard
    end
    if @user.discard
      session[:user_id] = nil
      flash[:notice]    = "ユーザーを削除しました"
      redirect_to("/signup")
    else
      @error_message = "削除に失敗しました"
      render("users/#{@user.id}")
    end
  end
  
  def settings
  end

  def follows
    @user   = User.kept.find_by(id: params[:id])
    @following_users = @user.following_user
    @follower_users  = @user.follower_user
    @users = @user.following_user.reverse_order
  end
  
  def followers
    @user   = User.kept.find_by(id: params[:id])
    @following_users = @user.following_user
    @follower_users  = @user.follower_user
    @users = @user.follower_user.reverse_order
  end

  def admin_settings
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :icon, :icon_cache)
  end
  def password_params
    params.require(:user).permit(:old_password, :password, :password_check)
  end
end
