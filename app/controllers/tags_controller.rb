class TagsController < ApplicationController
  #管理者アカウントのみがアクセスできる
  before_action :admin_user, {only: [:list]}
  
  def list
    @tags = Tag.all
  end

  def create_form
    @tag = Tag.new
    @categories = TagCategory.all
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      flash[:notice] = "追加しました"
      redirect_to("/tags")
    else
      render("tags/create_form")
    end
  end

  def category_list
    @categories = TagCategory.all
  end

  def create_category_form
    @category = TagCategory.new
  end

  def create_category
    @category = TagCategory.new(category_params)

    if @category.save
      flash[:notice] = "追加しました"
      redirect_to("/tags/categories")
    else
      render("tags/create_category_form")
    end
  end

  private
  def tag_params
    params.require(:tag).permit(:name, :tag_category_id)
  end
  def category_params
    params.require(:tag_category).permit(:name)
  end
end
