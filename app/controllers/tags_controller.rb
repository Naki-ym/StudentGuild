class TagsController < ApplicationController
  #管理者アカウントのみがアクセスできる
  before_action :admin_user, {only: [:list]}
  
  def list
    @tags = Tag.all
  end
end
