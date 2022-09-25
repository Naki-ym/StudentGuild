class Tag < ApplicationRecord
  has_many :projects_tags
  has_many :projects, through: :projects_tags
end
