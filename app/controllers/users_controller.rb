class UsersController < ApplicationController
  #ログインしていないユーザーがアクセスできない
  before_action :authenticate_user, {only: [:edit, :update, :logout, :destroy]}
  #ログインしているユーザーがアクセスできない
  before_action :forbid_login_user, {only: [:signup, :create, :login_form, :login]}

  def signup
  end
  def create
    @user = User.new(name: params[:name], email: params[:email], password: params[:password])
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザー登録が完了しました"
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
      flash[:notice] = "ログインしました"
      redirect_to("/users/#{@user.id}/")
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      render("users/login_form")
    end
  end
  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login")
  end
  def show
    @user = User.find_by(id: params[:id])
    @posts = Post.where(user_id: @user.id, is_deleted: false)
  end
  def edit
    @user = User.find_by(id: params[:id])
    @name = @user.name
    @email = @user.email
  end
  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    if @user.save
      flash[:notice] = "変更を保存しました"
      redirect_to("/users/#{@user.id}/")
    else
      @name = @user.name
    @email = @user.email
      render("users/edit")
    end
  end
  def delete
    @user = User.find_by(id: params[:id])
    @posts = Post.where(user_id: @user.id)
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
      flash[:notice] = "ユーザーを削除しました"
      redirect_to("/login")
    else
      @error_message = "削除に失敗しました"
      render("users/#{@user.id}")
    end
  end
  def settings
  end
end
