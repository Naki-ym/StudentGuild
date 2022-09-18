class ProjectsController < ApplicationController
  def board
    @projects = Project.where.not(user_id: @current_user.id).where(is_published: true, is_deleted: false).order(created_at: :desc)
  end
  def myproject
    @allmyprojects = Project.where(user_id: @current_user.id, is_deleted: false).order(created_at: :desc)
    @projects = @allmyprojects
    if params[:is_published] == "true"
      @projects = Project.where(user_id: @current_user.id, is_published: true, is_deleted: false).order(created_at: :desc)
    elsif params[:is_published] == "false"
      @projects = Project.where(user_id: @current_user.id, is_published: false, is_deleted: false).order(created_at: :desc)
    end
  end
  def create_project
    @project = Project.new
  end
  def create
    @project = Project.new(
      name: params[:name],
      user_id: @current_user.id,
      overview: params[:overview],
      target: params[:target],
      detail: params[:detail])
    if @project.save
      redirect_to("/myprojects")
    else
      render("projects/create_project")
    end
  end
  def show
    @project = Project.find_by(id: params[:id], is_deleted: false)
    @entry = Entry.find_by(user_id: @current_user.id, project_id: params[:id], is_deleted: false)
  end
  def publish
    @project = Project.find_by(id: params[:id], is_deleted: false)
    @project.is_published = true
    @project.save
    redirect_to("/myprojects")
  end
  def unpublish
    @project = Project.find_by(id: params[:id], is_deleted: false)
    @project.is_published = false
    @project.save
    redirect_to("/myprojects")
  end
  def entry_page
    @project = Project.find_by(id: params[:id], is_deleted: false)
    @entry = Entry.new
  end
  def entry
    @entry = Entry.new(user_id: @current_user.id, project_id: params[:id], content: params[:content])
    #応募済みでないか
    unless Entry.find_by(user_id: @current_user.id, project_id: params[:id], is_deleted: false)
      if @entry.save
        redirect_to("/")
      else
        render("projects/entry_page")
      end
    else
      @project = Project.find_by(id: params[:id], is_deleted: false)
      render("projects/entry_page")
    end
  end
  def entry_list
    @entries = Entry.where(project_id: params[:id], is_deleted: false)
  end
  def delete
    @project = Project.find_by(id: params[:id])
    @project.is_deleted = true
    @project.save
    redirect_to("/myprojects")
  end
end
