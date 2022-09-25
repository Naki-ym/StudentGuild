class Project < ApplicationRecord
  validates :user_id, {presence: true}
  validates :name, {presence: true, length: {maximum: 200}}
  validates :overview, {presence: true, length: {maximum: 200}}
  validates :target, {presence: true, length: {maximum: 200}}
  validates :detail, {presence: true}

  belongs_to :user
  has_many :entries
  has_many :projects_tags
  has_many :tags, through: :projects_tags

  mount_uploader :image, ProjectImageUploader

  def user
    return User.find_by(id: self.user_id, is_deleted: false)
  end
end
