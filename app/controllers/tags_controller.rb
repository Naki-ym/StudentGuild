class TagsController < ApplicationController
  #管理者アカウントのみがアクセスできる
  before_action :admin_user
  
  def list
    @tags = Tag.all.order(created_at: :asc)
  end

  def create_form
    @tag = Tag.new
    @categories = TagCategory.all.order(created_at: :asc)
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to("/tags")
    else
      @categories = TagCategory.all.order(created_at: :asc)
      render("tags/create_form")
    end
  end

  def edit
    @tag  = Tag.find_by(id: params[:id])
    @category = @tag.category
    @categories = TagCategory.all.order(created_at: :asc)
  end

  def update
    @tag  = Tag.find_by(id: params[:id])
    if @tag.update(tag_params)
      redirect_to("/tags")
    else
      render("tags/edit")
    end
  end

  def delete
    @tag = Tag.find_by(id: params[:id])
    @tag.delete
    redirect_to("/tags")
  end

  def category_list
    @categories = TagCategory.all.order(created_at: :asc)
  end

  def create_category_form
    @category = TagCategory.new
  end

  def create_category
    @category = TagCategory.new(category_params)

    if @category.save
      redirect_to("/tags/categories")
    else
      render("tags/create_category_form")
    end
  end

  def category_edit
    @category = TagCategory.find_by(id: params[:id])
  end

  def category_update
    @category = TagCategory.find_by(id: params[:id])
    if @category.update(category_params)
      redirect_to("/tags/categories")
    else
      render("tags/category_edit")
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
