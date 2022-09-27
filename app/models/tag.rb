class Tag < ApplicationRecord
  validates :name, {presence: true, length: {maximum: 30}}

  belongs_to :tag_category
  has_many :projects_tags
  has_many :projects, through: :projects_tags

  def category
    return TagCategory.find_by(id: self.tag_category_id)
  end
  def projects(user_id)
    project_tags = ProjectsTag.where(tag_id: self.id)
    projects     = []
    project_tags.each do |project_tag|
      tag_projects = Project.where(id: project_tag.project_id, is_published: true, is_deleted: false).where.not(user_id: user_id)
      tag_projects.each do |tag_project|
        projects.push(tag_project)
      end
    end
    return projects
  end
end
