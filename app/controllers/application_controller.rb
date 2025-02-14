class ApplicationController < ActionController::Base
  before_action :set_current_user
  
  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
    @user         = User.new
    @post         = Post.new
  end

  def authenticate_user
    if @current_user == nil
      flash[:notice] = "ログインが必要です"
      redirect_to("/login")
    end
  end

  def forbid_login_user
    if @current_user
      flash[:notice] = "既にログインしています"
      redirect_to("/users/#{@current_user.id}")
    end
  end

  def admin_user
    if @current_user.admin == false
      flash[:notice] = "管理者権限のあるアカウントのみアクセスできます"
      redirect_to("/users/#{@current_user.id}")
    end
  end
end
