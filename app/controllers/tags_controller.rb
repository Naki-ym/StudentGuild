class TagsController < ApplicationController
  #管理者アカウントのみがアクセスできる
  before_action :admin_user
  
  def list
    @tags = Tag.kept.order(created_at: :asc)
    @sort_list = {"作成順（昇順）": 1, "作成順（降順）": 2, "カテゴリ順": 3, "名前順": 4}
  end

  def sort_tag
    case params[:sort_tag].to_i
    when 1
      @tags = Tag.kept.order(created_at: :asc)
    when 2
      @tags = Tag.kept.order(created_at: :desc)
    when 3
      @tags = Tag.kept.order(tag_category_id: :asc, created_at: :asc)
    when 4
      @tags = Tag.kept.order(name: :asc, created_at: :asc)
    else
      @tags = Tag.kept.order(created_at: :asc)
    end
  end

  def create_form
    @tag = Tag.new
    @categories = TagCategory.kept.order(created_at: :asc)
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to("/tags")
    else
      @categories = TagCategory.kept.order(created_at: :asc)
      render("tags/create_form")
    end
  end

  def edit
    @tag  = Tag.kept.find_by(id: params[:id])
    @category = @tag.category
    @categories = TagCategory.kept.order(created_at: :asc)
  end

  def update
    @tag  = Tag.kept.find_by(id: params[:id])
    if @tag.update(tag_params)
      redirect_to("/tags")
    else
      render("tags/edit")
    end
  end

  def delete
    @tag = Tag.kept.find_by(id: params[:id])
    @tag.discard
    redirect_to("/tags")
  end

  def category_list
    @categories = TagCategory.kept.order(created_at: :asc)
    @sort_list = {"作成順（昇順）": 1, "作成順（降順）": 2, "名前順": 3}
  end

  def sort_tag_category
    case params[:sort_tag_category].to_i
    when 1
      @categories = TagCategory.kept.order(created_at: :asc)
    when 2
      @categories = TagCategory.kept.order(created_at: :desc)
    when 3
      @categories = TagCategory.kept.order(name: :asc, created_at: :asc)
    else
      @categories = TagCategory.kept.order(created_at: :asc)
    end
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
