class Tag < ApplicationRecord
  validates :name, {presence: true, length: {maximum: 30}}

  belongs_to :tag_category
  has_many :projects_tags
  has_many :projects, through: :projects_tags
end
